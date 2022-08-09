import 'dart:ui';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/utils/generate_color.dart';
import 'package:flutter/material.dart';

class Theming {
  static ThemeData theme() {
    return ThemeData(
      primarySwatch: generateMaterialColor(CustomColors.dark),
      scaffoldBackgroundColor: CustomColors.white,
      textTheme: TextTheme(
        headline1: CustomTextTheme.headLine(),
        subtitle1: CustomTextTheme.paragraph(),
        subtitle2: CustomTextTheme.paragraph2(),
      ),
    );
  }
}
