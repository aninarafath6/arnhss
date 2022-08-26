import 'package:arnhss/common/constants/api_constants.dart';
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
    ).then((val) => print(val));
    // return response;
  }
}
