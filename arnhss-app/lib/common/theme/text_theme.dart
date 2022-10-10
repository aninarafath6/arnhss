import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomTextTheme {
  CustomTextTheme({required this.context});
  final BuildContext context;

  TextStyle headLine() {
    return TextStyle(
      color: CustomColors.dark,
      fontSize: context.getHeight(2.6),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle headLine2() {
    return TextStyle(
      color: CustomColors.dark,
      fontSize: context.getHeight(2),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle paragraph() {
    return TextStyle(
      color: CustomColors.texty,
      fontWeight: FontWeight.normal,
      height: 1.5,
      fontSize: context.getHeight(1.7),
    );
  }

  TextStyle paragraph2() {
    return TextStyle(
      color: CustomColors.texty,
      fontSize: context.getHeight(1.3),
      fontWeight: FontWeight.normal,
      height: 1,
    );
  }
}
