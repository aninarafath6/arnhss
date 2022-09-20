import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/utils/generate_color.dart';
import 'package:flutter/material.dart';

class Theming {
  Theming({required this.context});
  final BuildContext context;

  ThemeData theme() {
    return ThemeData(
        primarySwatch: generateMaterialColor(CustomColors.dark),
        scaffoldBackgroundColor: CustomColors.white,
        chipTheme: ChipThemeData(
          backgroundColor: Colors.orange.withOpacity(.2),
        )

        // colorScheme: ColorScheme(
        //     brightness: brightness,
        //     primary: primary,
        //     onPrimary: onPrimary,
        //     secondary: secondary,
        //     onSecondary: onSecondary,
        //     error: error,
        //     onError: onError,
        //     background: background,
        //     onBackground: CustomColors.dark,
        //     surface: surface,
        //     onSurface: onSurface)

        // textTheme: TextTheme(
        //   headline1: CustomTextTheme.headLine(context),
        //   headline2: CustomTextTheme.headLine2(context),
        //   subtitle1: CustomTextTheme.paragraph(),
        //   subtitle2: CustomTextTheme.paragraph2(),
        // ),
        );
  }
}
