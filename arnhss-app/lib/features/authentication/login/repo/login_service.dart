import 'package:arnhss/common/constants/api_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/services/base_client.dart';
import 'package:arnhss/services/handle_exception.dart';

class LoginService with HandleException {
  final BaseClient _baseClient = BaseClient();

  Future<dynamic> getOtp(
      {required String phone, required String countryCode}) async {
    var response = await _baseClient.post(
      ApiConstatns.BASE_URL,
      ApiConstatns.GET_OTP,
      {
        "phone": phone.toString(),
        "countryCode": countryCode.toString(),
      },
    ).catchError(handleException);
    if (response["status"]) {
      return response;
    } else {
      customSnackBar(white: true, content: response["error"]);
    }
  }
}
