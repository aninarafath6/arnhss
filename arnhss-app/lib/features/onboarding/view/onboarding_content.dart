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
    return Container(
      // height: context.getHeight(40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !context.isMobile
                ? context.spacing(height: 15)
                : context.spacing(height: 5),
            // const Spacer(flex: 1),
            const Heading(),
            context.spacing(height: 2.5),

            const Content(),
            // const Spacer(flex: 1),
            context.spacing(height: context.isMobile ? 10 : 5.9),

            CustomButton(
              onTap: () => {
                Navigator.pushNamed(context, LoginView.routeName),
              },
              width: context.isMobile
                  ? context.getWidth(100)
                  : context.getWidth(50),
              height: context.isMobile ? context.getHeight(8) : 60,
              fontSize: context.isMobile ? 15 : 18,
            ),

            // !context.isMobile ? const Spacer(flex: 1) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
