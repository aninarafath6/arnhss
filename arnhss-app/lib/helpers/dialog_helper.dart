import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

import 'package:get/get.dart';

class DialogHelper {
  // error snackbar
  static void showErrorDialog(
      {String? title = "Oops 🤔", String? description, bool top = false}) {
    Get.snackbar(
      title ?? "",
      description ?? "something went wrong",
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.white.withOpacity(.5),
      snackPosition: top ? SnackPosition.TOP : SnackPosition.BOTTOM,
    );
  }

  static void showSnackBar(
      {String? title = "OTP 📲",
      String? description,
      Duration? duration = const Duration(seconds: 3),
      bool top = false}) {
    Get.snackbar(
      title ?? "",
      description ?? "something went wrong",
      backgroundColor: CustomColors.lightBgOverlay,
      margin: const EdgeInsets.all(20),

      snackPosition: top ? SnackPosition.TOP : SnackPosition.BOTTOM,
      duration: duration,
    );
  }
}
