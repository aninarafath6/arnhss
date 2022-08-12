import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context,
    {required String title, FocusNode? focus}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      splashRadius: 25,
      onPressed: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        } else {
          Navigator.pop(context);
        }
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: CustomColors.dark,
      ),
    ),
    title: Text(
      title,
      style: CustomTextTheme(context: context).headLine(),
    ),
  );
}
