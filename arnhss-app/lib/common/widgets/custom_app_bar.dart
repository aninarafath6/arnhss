import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar customAppBar(BuildContext context,
    {required String title,
    FocusNode? focus,
    Function()? onBack,
    bool? center,
    List<Widget>? actions}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Colors.white,
    centerTitle: center,
    elevation: 0,
    leading: IconButton(
      splashRadius: 25,
      onPressed: () {
        if (context.isKeyboard) {
          FocusScope.of(context).unfocus();
        } else {
          Navigator.pop(context);
        }
        onBack?.call();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: CustomColors.dark,
      ),
    ),
    actions: actions,
    title: Text(
      title,
      style:
          CustomTextTheme(context: context).headLine().copyWith(fontSize: 20),
    ),
  );
}
