import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/features/onboarding/view/onboard_background.dart';
import 'package:arnhss/features/onboarding/view/onboarding_content.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("=====onboarding screen=====");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getWidth(0)),
          child: Stack(
            children: [
              Background(image: Images.onboarding_image),
              const OnboardingContent(),
            ],
          ),
        ),
      ),
    );
  }
}
