import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/route_manager.dart';

class SplashView extends StatefulWidget {
  static const routeName = "/splash";
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SharedPrefService _sharedPrefService = SharedPrefService();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () async {
        String routeName = await _sharedPrefService.start();
        Get.offNamedUntil(routeName, (_) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("=====splash screen=====");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: context.getWidth(100),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  Images.splash_logo,
                  width: 200,
                ),
              ),
              const Spacer(),
              Text(
                "BY COMPUTER⚡SCIENCE 2021-23.",
                style: TextStyle(
                  fontSize: context.isMobile
                      ? context.getHeight(1.5)
                      : context.getWidth(1.5),
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 15),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
