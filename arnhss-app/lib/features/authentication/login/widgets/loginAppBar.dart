import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar customLoginAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      splashRadius: 25,
      onPressed: () {
        if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
          context.read<LoginViewModel>().myFocusNode.unfocus();
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: CustomColors.dark,
      ),
    ),
    title: Text(
      "Login",
      style: CustomTextTheme(context: context).headLine(),
    ),
  );
}
