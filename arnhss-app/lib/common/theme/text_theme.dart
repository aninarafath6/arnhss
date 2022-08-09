import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomTextTheme {
  static TextStyle headLine() {
    return const TextStyle(
      color: CustomColors.dark,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headLine2() {
    return const TextStyle(
      color: CustomColors.dark,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle paragraph() {
    return const TextStyle(
      color: CustomColors.texty,
      fontSize: 15,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle paragraph2() {
    return const TextStyle(
      color: CustomColors.texty,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }
}
