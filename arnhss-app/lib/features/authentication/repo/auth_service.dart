import 'dart:async';
import 'dart:convert';

import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/extensions/enum_extension.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class AuthService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

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
          print("verification is completed");
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
      Callback? errorCallback}) async {
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
      //   print(e);()

      //* error callback
      errorCallback!();
      //* handling the exception
      handleException(e);
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

  void updateUserProfile(UserModel user) async {
    CollectionReference _collectionRef;

    try {
      if (user.role == Role.admin || user.role == Role.student) {
        _collectionRef =
            _firestoreInstance.collection(FirebaseConstants.userCollection);
        _collectionRef
            .doc(user.id)
            .update({"last_login": DateTime.now(), "status": true}).then(
                (value) => debugPrint("user login status is updated"));
      } else if (user.role == Role.student) {
      } else if (user.role == Role.teacher) {
      } else {}
    } catch (e) {
      handleException(
          InvalidException("User current status is not updated!!", false));
    }

    try {
      var _user = _firebaseAuth.currentUser;
      await _user?.updateDisplayName(user.name);
      await _user?.updateEmail(user.email.toString());
      await _user?.updatePhotoURL(user.dpURL);
    } catch (e) {
      handleException(InvalidException("User Profile is not updated!!", false));
    }
  }

  Future<List<UserModel>?> getUsersList(String phone, Role role) async {
    QuerySnapshot? querySnapshot;
    final _usersCollection = _firestoreInstance
        .collectionGroup(FirebaseConstants.getCollectionName(role));

    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint("${role.describe}'s phone number is $phone");
      debugPrint("Selecting ${role.describe}'s  account......");

      if (role == Role.student) {
        querySnapshot = await _usersCollection
            .where("phone", isEqualTo: phone)
            .where("role", isEqualTo: role.describe)
            .get();
      } else {
        querySnapshot = await _usersCollection
            .where("phone", isEqualTo: phone)
            .where("role", isEqualTo: role.describe)
            .get();
      }

      debugPrint(querySnapshot.docs.toString());

      return Future.wait(querySnapshot.docs.map((e) async {
        // courseDetails  = courseDetails.data();
        // print(courseDetails?.data());

        if (role == Role.student) {
          var divisionDetails = await e.reference.parent.parent?.get();
          var batchDetails =
              await divisionDetails?.reference.parent.parent?.get();
          var courseDetails = await divisionDetails
              ?.reference.parent.parent?.parent.parent
              ?.get();
          UserModel user = UserModel.fromRawJson(
            <String, dynamic>{
              ...e.data() as Map<String, dynamic>,
              "batch": batchDetails?.data()?["name"],
              "department": courseDetails?.data()?["name"]
            },
            e.id,
          );
          debugPrint(user.id.toString() + "is id for " + user.name.toString());

          debugPrint(user.lastLogin.toString() +
              "is last log time of  " +
              user.name.toString());
          return user;
        } else {
          UserModel user = UserModel.fromRawJson(
            <String, dynamic>{
              ...e.data() as Map<String, dynamic>,
            },
            e.id,
          );
          return user;
        }
      }).toList());
    } catch (e) {
      print(e);
      handleException(e);
      return null;
    }
  }

  // Future<List<T>?> getListUsers<T>(String phone, Role role) async {
  //   // * get users who have the same number
  //   QuerySnapshot? querySnapshot;
  //   // QuerySnapshot? studentsSnapshot;
  //   // QuerySnapshot? teacherSnapshot;

  //   // List<UserModel>? docs;

  //   final CollectionReference _usersCollection =
  //       FirebaseFirestore.instance.collection('users');
  //   // final CollectionReference _studentsCollection =
  //   //     FirebaseFirestore.instance.collection('students');
  //   // final CollectionReference _teachersCollection =
  //   //     FirebaseFirestore.instance.collection('teachers');
  //   // final CollectionReference _studentCollection =
  //   //     FirebaseFirestore.instance.collection('users');

  //   try {
  //     // * dummy delay
  //     await Future.delayed(const Duration(seconds: 1));

  //     switch (role) {
  //       case Role.admin:
  //         debugPrint("admin phone number is $phone");
  //         debugPrint("Selecting Admin account account......");
  //         querySnapshot =
  //             await _usersCollection.where("phone", isEqualTo: phone).get();
  //         // return querySnapshot.docs
  //         //     .map((e) => T.fromRawJson(jsonEncode(e.data())))
  //         //     .toList();

  //         // return "a";
  //         // return
  //         // case Role.principle:
  //         //   querySnapshot =
  //         //       await _usersCollection.where("phone", isEqualTo: phone).get();
  //         //   docs = querySnapshot.docs
  //         //       .map((e) => UserModel.fromRawJson(jsonEncode(e.data())))
  //         //       .toList();
  //         break;

  //       default:
  //     }

  //     // // * fetch the document which have same phone number
  //     // await Future.delayed(const Duration(seconds: 1));

  //     // studentsSnapshot =
  //     //     await _studentsCollection.where("phone", isEqualTo: phone).get();
  //     // teacherSnapshot =
  //     //     await _teachersCollection.where("phone", isEqualTo: phone).get();

  //     // docs = [
  //     //   //! there is a conflict when convert student model to user model so there is need a check
  //     //   // ...studentsSnapshot.docs
  //     //   //     .map((e) => UserModel.fromRawJson(jsonEncode(e.data())))
  //     //   //     .toList(),
  //     // ];

  //     // querySnapshot.docs

  //     // docs = [
  //     //   ...studentsSnapshot.docs
  //     //       .map((e) => UserModel.fromRawJson(jsonEncode(e.data())))
  //     //       .toList(),
  //     //   ...teacherSnapshot.docs
  //     //       .map((e) => UserModel.fromRawJson(jsonEncode(e.data())))
  //     //       .toList(),
  //     //   ...querySnapshot.docs
  //     //       .map((e) => UserModel.fromRawJson(jsonEncode(e.data())))
  //     //       .toList()
  //     // ];
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     handleException(e);
  //     return null;
  //   }

  //   // * if query snapshot has data then return data other wise return null
  //   // if (docs!.isNotEmpty) {
  //   //   debugPrint("users found");
  //   //   print(docs);
  //   //   return docs;
  //   // } else {
  //   //   debugPrint("docs is null");
  //   //   return null;
  //   // }
  // }

// * sign out user
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _prefService.clear();
    } catch (e) {
      handleException(e);
    }
  }
}
