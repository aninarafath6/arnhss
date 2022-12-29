import 'dart:developer';

import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandleException {
  void handleException(error, {bool top = false}) {
    print("what type");
    // print(error.message);
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
      // log(error.message.toString(), name: error.code);
      // print("this is firebase exception");

      // DialogHelper.showErrorDialog(
      //     description: error.code, title: "Oops 🥸", top: top);
      handleFirebaseErrors(error, top);
    } else if (error is InvalidException) {
      log(error.message.toString(), name: error.prefix.toString());

      DialogHelper.showErrorDialog(
          description: error.message, title: "Oops 🥸", top: top);
    } else if (error
        .toString()
        .contains("firebase_database/permission-denied")) {
      log("database access denied", name: "");

      DialogHelper.showErrorDialog(
        description: "Sorry, your notice board access dined please  re-login",
        title: "Oops 🥸",
        top: top,
      );
    } else {
      DialogHelper.showErrorDialog(
          description: "Something went wrong!", title: "Oops 🥸", top: top);
    }
  }

  handleFirebaseErrors(FirebaseAuthException error, top) {
    if (error.code == "network-request-failed") {
      print("this is firebase exception");
      return DialogHelper.showErrorDialog(
          description: "Sorry, Network connection lost....",
          title: "Oops 🥸",
          top: top);
    } else {}
  }
}
