import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';

class HandleException {
  void handleException(error) {
    debugPrint("handle exception");
    if (error is BadRequestException) {
      customSnackBar(content: error.message);
    } else if (error is FetchDataException) {
      customSnackBar(content: error.message);
    } else if (error is ApiNotRespondingException) {
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
