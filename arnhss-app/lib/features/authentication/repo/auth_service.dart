import 'dart:async';

import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SharedPrefService _prefService = SharedPrefService();

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get user {
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
        verificationCompleted: (PhoneAuthCredential credential) async {},
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
          print("from from from");
          throw e;
        },
      );
    } catch (e) {
      //* handle exception.
      handleException(e);
    }
  }

// * verify otp
  Future<AuthCredential?> verifyOtp({String? vi, String? otp}) async {
    //* verify otp with phone auth provider
    AuthCredential? _credential;
    try {
      _credential =
          PhoneAuthProvider.credential(verificationId: vi!, smsCode: otp!);
    } catch (e) {
      handleException(e);
    }
    return _credential;
  }

  Future<void> signIn(AuthCredential? credential, UserModel user) async {
    // UserCredential? _userCredential;

    try {
      // * user credential
      if (credential != null) {
        await _firebaseAuth.signInWithCredential(credential).catchError(
          (error) {
            debugPrint("throwing error from here");
            throw error;
          },
        ).then(
          ((value) async {
            updateUserProfile(user);
          }),
        );
      } else {
        throw InvalidException("Something went wrong!!", false);
      }
      //* handle firebase exception
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      handleException(InvalidException(e.code, false), top: true);
    } catch (e) {
      debugPrint("here $e");
      handleException(e);
    }

    //* return the user credential
    // return _userCredential;
  }

  void updateUserProfile(UserModel user) async {
    try {
      var _user = _firebaseAuth.currentUser;
      await _user?.updateDisplayName(user.name);
      await _user?.updatePhotoURL(user.dpURL);
      print("updating...");
    } catch (e) {
      handleException(InvalidException("User Profile is not updated!!", false));
    }
  }

  Future<List<UserModel>?> getListUsers(String phone) async {
    // * get users who have the same number
    QuerySnapshot? querySnapshot;

    try {
      // * fetch the document which have same phone number
      await Future.delayed(const Duration(seconds: 1));
      querySnapshot =
          await _usersCollection.where("phone", isEqualTo: phone).get();
    } catch (e) {
      handleException(e);
    }

// * if query snapshot has data then return data other wise return null
    if (querySnapshot != null) {
      return UserModel.listFromJson(querySnapshot);
    } else {
      return null;
    }
  }

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
