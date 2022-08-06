import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "/onboarding";
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.getWidth(100),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                "assets/images/pngs/logo.png",
                width: context.getWidth(55),
              ),
              const Spacer(),
              Text(
                "Beta version 0.0.1",
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
