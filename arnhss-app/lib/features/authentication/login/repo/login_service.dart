import 'package:arnhss/common/constants/api_constants.dart';
import 'package:arnhss/services/base_client.dart';

class LoginService {
  final BaseClient _baseClient = BaseClient();

  Future<dynamic> getOtp(
      {required String phone, required String countryCode}) async {
    var response = await _baseClient.post(
      ApiConstatns.BASE_URL,
      ApiConstatns.GET_OTP,
      {
        phone: phone,
        countryCode: countryCode,
      },
    );
    return response;
  }
}
