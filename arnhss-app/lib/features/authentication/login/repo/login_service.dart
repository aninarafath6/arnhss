import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getOtp(
      {required String phonenumber,
      required Function(String, int?) codeSetn}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // print('verification complicated');
          // print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // if (e.code == 'invalid-phone-number') {
          //   print('The provided phone number is not valid.');
          // }
        },
        codeSent: codeSetn,
        codeAutoRetrievalTimeout: ((String verificationId) => {}),
      );
    } catch (e) {
      debugPrint("catch in line no 23");
    }
  }
}
