import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService with HandleException {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> getOtp(
      {required String phone, required String countryCode}) async {
    print("country code is $countryCode");
    print(phone);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$countryCode $phone',
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          // throw InvalidException(e.message, false);
        },
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId);
          print(resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on InvalidException {
      print("invalid invalid invalid");
    } catch (e) {
      print("this is here");
      handleException(e);
      print(e);
    }
  }
}
