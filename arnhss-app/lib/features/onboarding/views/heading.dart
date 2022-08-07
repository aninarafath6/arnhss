import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Text(
        "Ar Nagar Hss- A complete educational institute",
        style: TextStyle(
          color: CustomColors.dark_text,
          fontSize: context.getHeight(2.5),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
