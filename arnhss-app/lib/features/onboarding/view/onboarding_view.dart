import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/widgets/layout/responsive_layout.dart';
import 'package:arnhss/features/onboarding/view/onboard_background.dart';
import 'package:arnhss/features/onboarding/view/onboarding_content.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("=====onboarding screen=====");

    List<Widget> _onboardingContent = [
      Expanded(child: Background(image: Images.onboarding_image)),
      const Expanded(child: OnboardingContent()),
    ];

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.default_padding),
            child: ResponsiveLayout(
              mobile: Column(children: _onboardingContent),
              tablet: Row(children: _onboardingContent),
            ),
          ),
        ),
      ),
    );
  }
}
