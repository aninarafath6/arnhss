import 'dart:developer';

import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandleException {
  void handleException(error, {bool top = false}) {
    if (error is BadRequestException) {
      var message = error.message;

      // print(error);
      DialogHelper.showErrorDialog(description: message, top: top);
    } else if (error is FetchDataException) {
      log(error.message.toString(), name: error.prefix.toString());
      var message = error.message;
      DialogHelper.showErrorDialog(description: message, top: top);
    } else if (error is ApiNotRespondingException) {
      log(error.message.toString(), name: error.prefix.toString());

      // var message = error.message;
      DialogHelper.showErrorDialog(
          description: "It took longer to respond.", top: top);
    } else if (error is FirebaseAuthException) {
      log(error.message.toString(), name: error.code);

      DialogHelper.showErrorDialog(
          description: error.code, title: "Oops 🥸", top: top);
    } else if (error is InvalidException) {
      log(error.message.toString(), name: error.prefix.toString());

      DialogHelper.showErrorDialog(
          description: error.message, title: "Oops 🥸", top: top);
    } else {
      DialogHelper.showErrorDialog(
          description: "Something went wrong!", title: "Oops 🥸", top: top);
    }
  }
}
