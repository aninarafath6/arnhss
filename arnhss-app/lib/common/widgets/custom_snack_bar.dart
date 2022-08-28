import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar(
    {String? content = "something went wrog!!🫡", bool white = false}) {
  Get.snackbar(
    'Ooooops!',
    content ?? "something went wrog!!🫡",
    snackPosition: SnackPosition.TOP,
    backgroundColor: white
        ? Colors.white.withOpacity(.5)
        : CustomColors.dark.withOpacity(.1),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    isDismissible: true,
  );
}
