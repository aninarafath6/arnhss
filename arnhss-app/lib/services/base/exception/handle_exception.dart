import 'package:arnhss/helpers/dailog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';

class HandleException {
  void handleException(error) {
    // print(error);
    if (error is BadRequestException) {
      var message = error.message;
      // print(error);
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      // var message = error.message;
      DialogHelper.showErrorDialog(description: "It took longer to respond.");
    } else if (error is InvalidException) {
      DialogHelper.showErrorDialog(
          description: error.message, title: "Oops 🥸");
    }
  }
}
