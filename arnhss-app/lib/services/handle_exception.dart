import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/services/app_exceptions.dart';

class HandleException {
  void handleException(error) {
    print("handiling");
    if (error is BadRequestException) {
      customSnackBar(content: error.message);
    } else if (error is FetchDataException) {
      customSnackBar(content: error.message);
    } else if (error is ApiNotRespodingException) {
      customSnackBar(content: "It's take longer to respond...");
    } else if (error is UnAuthorizedException) {
      customSnackBar(content: error.message);
    } else if (error is InvalidException) {
      customSnackBar(content: error.message, white: true);
    } else {
      customSnackBar();
    }
  }
}
