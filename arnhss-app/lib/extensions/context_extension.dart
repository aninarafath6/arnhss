import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  // taking the screen width and height

  Size get mqS => MediaQuery.of(this).size;
  EdgeInsets get mqVI => MediaQuery.of(this).viewInsets;

  double getHeight(height) => (mqS.height / 100) * height;
  double getWidth(width) => (mqS.width / 100) * width;

  // check keyboard is open or not
  bool get isKeyboard => mqVI.bottom != 0;
  double get bottomINset => mqVI.bottom;

// for responsive stuffs
  bool get isMobile => mqS.width < AppSizes.kMobil;

  bool get isTablet =>
      mqS.width < AppSizes.kTablet && mqS.width >= AppSizes.kMobil;

  bool isDesktop() => mqS.width >= AppSizes.kDesktop;

// spacing widget
  SizedBox spacing({
    double? height = 0,
    double? width = 0,
  }) =>
      SizedBox(
        height: getHeight(height),
        width: getWidth(width),
      );

  //* ==== Role based stuffs ======
  Future<Role> get role async {
    return await SharedPrefService().getRole() ?? Role.student;
  }
}
