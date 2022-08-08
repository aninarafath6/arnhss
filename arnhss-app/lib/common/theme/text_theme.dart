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

  static TextStyle paragraph() {
    return const TextStyle(
      color: CustomColors.texty,
      fontSize: 15,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }
}
