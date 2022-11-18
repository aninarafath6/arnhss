import 'package:arnhss/features/authentication/login/view/login.dart';
import 'package:arnhss/features/onboarding/view/content.dart';
import 'package:arnhss/features/onboarding/view/heading.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/extensions/context_extension.dart';
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
        height: context.getHeight(40),
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
              context.spacing(height: 2),
              const Spacer(flex: 1),
              const Heading(),
              context.spacing(height: 2.5),
              const Content(),
              const Spacer(flex: 2),
              CustomButton(
                onTap: () => {
                  Navigator.pushNamed(context, LoginView.routeName),
                },
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
