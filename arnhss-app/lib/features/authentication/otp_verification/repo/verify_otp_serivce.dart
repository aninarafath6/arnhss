import 'package:arnhss/common/constants/api_constants.dart';
import 'package:arnhss/services/base_client.dart';
import 'package:arnhss/services/handle_exception.dart';

class VerifyOtpService with HandleException {
  final BaseClient _baseClient = BaseClient();

  Future<dynamic> verifyOtp(
      {required String phone,
      required String otp,
      required String countryCode}) async {
    await _baseClient.post(ApiConstatns.BASE_URL, ApiConstatns.VERIFY_OTP, {
      "phone": phone,
      "otp": otp,
      "countryCode": countryCode,
    }).catchError(handleException);
  }
}
