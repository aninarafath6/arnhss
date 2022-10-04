import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar notificationsAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    elevation: 0,
    title: const Text(
      "Notifications",
      style: TextStyle(color: CustomColors.dark),
    ),
    leading: IconButton(
        onPressed: () => Navigator.pop(context),
        splashRadius: 28,
        icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
  );
}
