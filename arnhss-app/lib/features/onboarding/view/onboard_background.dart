import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(70),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Image.asset(
          Images.onboarding_image,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
