

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: CustomColors.bgOverlay,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const CupertinoActivityIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
