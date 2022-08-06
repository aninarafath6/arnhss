import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/fetures/onboarding/views/onboard_background.dart';
import 'package:arnhss/fetures/onboarding/views/onboarding_content.dart';
import 'package:arnhss/fetures/widgets/custom_button.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.getWidth(0)),
        child: Stack(
          children: const [
            Background(),
            OnboardingContent(),
          ],
        ),
      ),
    );
  }
}





