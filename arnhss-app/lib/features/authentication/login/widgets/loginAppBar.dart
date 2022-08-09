import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

AppBar customLoginAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        splashRadius: 25,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: CustomColors.dark,
        ),
      ),
      title: Text(
        "Login",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
