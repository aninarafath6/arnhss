import 'dart:async';
import 'dart:developer';

import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/enum_extension.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/firebase_common_service.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class AuthService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;

  final FirebaseCommonService _firebaseCommonService = FirebaseCommonService();

  final SharedPrefService _prefService = SharedPrefService();

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> getOtp({
    required String phone,
    required String countryCode,
    required int timeout,
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
    int? resentToken,
  }) async {
    debugPrint("phone no is ${countryCode + phone}");
    try {
      await _firebaseAuth
          .verifyPhoneNumber(
        //* phone number
        phoneNumber: '$countryCode $phone',
        // * verification complete callback
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint("verification is completed");
        },
        // * handle verification failed state
        verificationFailed: verificationFailed,
        // * handle call back when the code sent
        codeSent: codeSent,
        forceResendingToken: resentToken,
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("verification $verificationId");
        },
        timeout: Duration(seconds: timeout),
      )
          .catchError(
        //* handle error
        (e) {
          debugPrint("from from from");
          throw e;
        },
      );
    } catch (e) {
      //* handle exception.
      handleException(e);
    }
  }

// * verify otp
  Future<bool> verifyOtp(
      {String? vi,
      String? otp,
      Callback? callback,
      Function(dynamic)? errorCallback}) async {
    //* verify otp with phone auth provider
    AuthCredential credential =
        PhoneAuthProvider.credential(verificationId: vi!, smsCode: otp!);
    try {
      // * user credential
      return await _firebaseAuth.signInWithCredential(credential).catchError(
        (error) {
          debugPrint("throwing error from here");
          throw error;
        },
      ).then((value) {
        callback!();
        return true;
      });
    } catch (e) {
      print(e);

      //* error callback
      handleException(e);
      errorCallback!(e);
      //* handling the exception
      return false;
    }
  }

// * sign in function the function will execute after selecting the account
  Future<void> signIn(AuthCredential? credential, UserModel user) async {
    try {
      //* update user profile things in auth state
      updateUserProfile(user);
    } catch (e) {
      handleException(e);
    }
  }

// * update profile method
  void updateUserProfile(UserModel user) async {
    // * collection reference
    final QuerySnapshot _collectionRef = await _firestoreInstance
        .collectionGroup(FirebaseConstants.getCollectionName(user.role!))
        .get();

    try {
      // * updating the last login time and setting status into true;

      _collectionRef.docs
          .where((element) => element.id == user.id)
          .first
          .reference
          .update({"last_login": Timestamp.now(), "status": true});

      // .doc(user.id)
      // .update({"last_login": DateTime.now(), "status": true}).then(
      //     (value) => debugPrint("user login status is updated"));
    } catch (e) {
      debugPrint(e.toString() + " error from update profile method");
      handleException(
          InvalidException("User current status is not updated!!", false));
    }

    //* updating firebase user profile
    try {
      var _user = _firebaseAuth.currentUser;
      await _user?.updateDisplayName(user.name);
      await _user?.updateEmail(user.email.toString());
      await _user?.updatePhotoURL(user.dpURL);
    } catch (e) {
      // print("error from user updating function on auth service $e");
      handleException(InvalidException("User Profile is not updated!!", false));
    }
  }

//* get users list for account selection
  Future<List<UserModel>?> getUsersList(String phone, Role role) async {
    QuerySnapshot? querySnapshot;
    //* collection reference
    final _usersCollection = _firestoreInstance
        .collectionGroup(FirebaseConstants.getCollectionName(role));

    try {
      //* dummy delay for loading
      await Future.delayed(const Duration(seconds: 1));
      debugPrint("${role.describe}'s phone number is $phone");
      debugPrint("Selecting ${role.describe}'s  account......");

      //* fetching user collection with phone and role number
      querySnapshot = await _usersCollection
          .where("phone", isEqualTo: phone)
          .where("role", isEqualTo: UserModel.toStringRole(role))
          .get();

      debugPrint(querySnapshot.docs.toString());

      //* converting map users list to user model list with future.wait
      return Future.wait(querySnapshot.docs.map((e) async {
        /*
         * if role is student then fetch division details and batch details and also course details
         * then map that data into [UserModel]
        */
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        DateTime lastLogin = data["last_login"].toDate() as DateTime;

        if (role == Role.student) {
          //* fetching division details
          var batchDetails = await e.reference.parent.parent?.get();

          //* fetching batch details
          var courseDetails =
              await batchDetails?.reference.parent.parent?.get();

          // //* fetching course details
          // var courseDetails = await divisionDetails
          //     ?.reference.parent.parent?.parent.parent
          //     ?.get();

          DateTime dob = data["dob"].toDate() as DateTime;

          String? dpURL = await _firebaseCommonService.getStudentDP(
            batchDetails?.reference,
            e.id,
          );

          //* map
          UserModel user = UserModel.fromRawJson(
            <String, dynamic>{
              ...data,
              "batch": batchDetails?.data()?["name"],
              "department": courseDetails?.data()?["name"],
              "last_login": lastLogin.microsecondsSinceEpoch,
              "dob": dob.microsecondsSinceEpoch,
              "dpURL": dpURL,
            },
            e.id,
          );

          //? debug printings for identification
          debugPrint(user.id.toString() + "is id for " + user.name.toString());
          debugPrint(user.lastLogin.toString() +
              "is last log time of  " +
              user.name.toString());

          //? printing user details for only reference
          log(user.toRawJson());
          return user;
        } else if (role == Role.teacher) {
          var subjectDetails = await data["subject"].get();

          String? dpURL = await _firebaseCommonService.getTeacherDP(e.id);
          // print(subjectDetails.data()["name"]);
          UserModel user = UserModel.fromRawJson(<String, dynamic>{
            ...data,
            "subject": subjectDetails.data()["name"],
            "last_login": lastLogin.microsecondsSinceEpoch,
            "dpURL": dpURL,
          }, e.id);

          //? testing
          log(user.toRawJson());

          return user;
        } else {
          // * if role is not student then just map with this data

          String? dpURL = await _firebaseCommonService.getAdminDP(e.id);
          UserModel user = UserModel.fromRawJson(
            <String, dynamic>{
              ...e.data() as Map<String, dynamic>,
              "last_login": lastLogin.microsecondsSinceEpoch,
              "dpURL": dpURL,
            },
            e.id,
          );
          return user;
        }
      }).toList());
    } catch (e) {
      //* exception handling
      debugPrint(e.toString() + "error from getUser list function");
      handleException(e);
      return null;
    }
  }

// * sign out user
  Future<void> logout(UserModel? user) async {
    if (user != null) {
      // * collection reference

      try {
        final QuerySnapshot _collectionRef = await _firestoreInstance
            .collectionGroup(FirebaseConstants.getCollectionName(user.role!))
            .get();
        _collectionRef.docs
            .where((element) => element.id == user.id)
            .first
            .reference
            .update({"status": false}).then(
          (value) async {
            await _firebaseAuth.signOut();
            log("logout success✅", zone: Zone.current, name: "logout");
          },
        ).catchError((e) {
          debugPrint("error from logout status update");
          handleException(e);
        });
      } catch (e) {
        log("error from logout function $e");
        handleException(e);
      }
    }
    _prefService.clear();

    // try {} catch (e) {
    //   handleException(e);
    // }
  }

  User? getCurrentUser() {
    // _firebaseAuth.currentUser.getIdToken(true);
    return _firebaseAuth.currentUser;
  }
}
