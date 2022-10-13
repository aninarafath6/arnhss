import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
            verificationCompleted: (PhoneAuthCredential credential) {
              debugPrint("credential");
              debugPrint(credential.toString());
            },
            // * handle verification failed state
            verificationFailed: (FirebaseAuthException e) {
              handleException(InvalidException(e.message, false));
            },
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
            (e) => handleException(
              Exception("something went wrong!"),
            ),
          );
    } catch (e) {
      //* handle exception.
      handleException(e);
    }
  }

  Future<UserCredential?> verifyOtp({String? vi, String? otp}) async {
    AuthCredential _credential =
        PhoneAuthProvider.credential(verificationId: vi!, smsCode: otp!);
    UserCredential? _userCredential;
    debugPrint("verification id is $vi");

    try {
      _userCredential = await _firebaseAuth
          .signInWithCredential(_credential)
          .catchError((error) {
        debugPrint("throwing error from here");
        throw error;
      }).then(
        ((value) {
          debugPrint("user credential is $value");
          return value;
        }),
      );
      // print(_userCredential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      handleException(InvalidException(e.code, false), top: true);
    } catch (e) {
      debugPrint("here $e");
      handleException(e);
    }

    return _userCredential;
  }
}
