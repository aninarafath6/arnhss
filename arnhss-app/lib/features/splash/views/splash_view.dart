import 'dart:async';

import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  static const routeName = "/splash";
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, "/onboarding"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: context.getWidth(100),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
               Images.splash_logo,
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
