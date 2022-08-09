import 'package:arnhss/features/onboarding/views/onboard_background.dart';
import 'package:arnhss/features/onboarding/views/onboarding_content.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getWidth(0)),
          child: Stack(
            children: const [
              Background(),
              OnboardingContent(),
            ],
          ),
        ),
      ),
    );
  }
}
