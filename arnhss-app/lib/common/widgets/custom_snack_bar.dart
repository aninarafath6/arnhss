import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({String? content = "something went wrog!!🫡"}) {
  Get.snackbar(
    'Ooooops!',
    content!,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    isDismissible: true,
  );
}
