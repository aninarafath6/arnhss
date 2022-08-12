import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String content) {
  SnackBar snackBar = SnackBar(
    backgroundColor: CustomColors.dark,
    content: Text(content),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
