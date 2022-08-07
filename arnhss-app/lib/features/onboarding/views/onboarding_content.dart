import 'package:arnhss/features/onboarding/views/content.dart';
import 'package:arnhss/features/onboarding/views/heading.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: context.getHeight(45),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            children: [
              context.spacing(height: 1),
              const Spacer(flex: 1),
              const Heading(),
              context.spacing(height: 2),
              const Content(),
              const Spacer(flex: 2),
              const CustomButton(),
              // const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
