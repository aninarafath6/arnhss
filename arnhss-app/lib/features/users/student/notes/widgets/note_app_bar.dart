import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arnhss/common/constants/color_constants.dart';

AppBar notesAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      splashRadius: 28,
      icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark),
    ),
    title: Text(
      title,
      style: const TextStyle(color: CustomColors.dark),
    ),
  );
}
