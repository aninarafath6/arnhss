import 'dart:ui';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Theming {
  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: CustomColors.white,
      textTheme: TextTheme(
        headline1: CustomTextTheme.headLine(),
      ),
    );
  }
}
