import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> getOtp({
    required String phone,
    required String countryCode,
    required int timeout,
    required Function(String, int?) codeSent,
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
              // var user = await _firebaseAuth.currentUser!;
              // print("complted");
              // print(credential);
            },
            // * handle verification failed state
            verificationFailed: (FirebaseAuthException e) {
              handleException(InvalidException(e.message, false));
              // Get.back();
            },
            // * handle call back when the code sent
            codeSent: codeSent,
            // forceResendingToken: resentToken,
            codeAutoRetrievalTimeout: (String verificationId) {
              debugPrint("verification $verificationId");
            },
            timeout: Duration(seconds: timeout),
          )
          .catchError(
            //* handle error
            (e) => handleException(
              Exception("something went wrong!"),
            ),
          );
    } catch (e) {
      //* handle exception.
      handleException(e);
    }
  }

// * verify otp
  Future<UserCredential?> verifyOtp({String? vi, String? otp}) async {
    //* verify otp with phone auth provider
    AuthCredential? _credential;
    try {
      _credential =
          PhoneAuthProvider.credential(verificationId: vi!, smsCode: otp!);
      // print(_credential.toString() + " this is credential");
    } catch (e) {
      // print(e);
      handleException(e);
    }
    UserCredential? _userCredential;
    debugPrint("verification id is $vi");

    if (_credential != null) {      try {
        // * user credential
        _userCredential = await _firebaseAuth
            .signInWithCredential(_credential)
            .catchError((error) {
          debugPrint("throwing error from here");
          throw error;
        }).then(
          ((value) {
            // print("here here here here");
            return value;
          }),
        );
        //* handle firebase exception
      } on FirebaseAuthException catch (e) {
        debugPrint(e.code);
        handleException(InvalidException(e.code, false), top: true);
      } catch (e) {
        debugPrint("here $e");
        handleException(e);
      }
    }
    //* return the user credential
    return _userCredential;
  }

  // Future<

  Future<List<UserModel>?> getListUsers() async {
    // * get users who have the same number
    QuerySnapshot? querySnapshot;
    if (_firebaseAuth.currentUser != null) {
      try {
        // * fetch the document which have same phone number
        await Future.delayed(const Duration(seconds: 1));
        querySnapshot = await users
            .where("phone", isEqualTo: _firebaseAuth.currentUser?.phoneNumber)
            .get();
      } catch (e) {
        handleException(e);
      }
    } else {
      handleException(InvalidException("Log credential is not exist", false));
    }

    if (querySnapshot != null) {
      return UserModel.listFromJson(querySnapshot);
    } else {
      return null;
    }
  }
}
