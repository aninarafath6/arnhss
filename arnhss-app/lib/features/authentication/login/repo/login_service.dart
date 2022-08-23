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
          print('verification complicated');
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: codeSetn,
        codeAutoRetrievalTimeout: ((String verificationId) => {}),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
