import 'dart:developer';

import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:arnhss/services/local_notificatoin_service.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    //* this function will work while app is still background.
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

    //* only work when the app is working on foreground
    //* this will not work on background
    FirebaseMessaging.onMessage.listen(_handleMessage);

    //* Also handle any interaction when the app is in the background via a
    //* Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    Timer(
      const Duration(seconds: 3),
      () async {
        String routeName = await _sharedPrefService.start();
        Get.offNamedUntil(routeName, (_) => false);
      },
    );
    super.initState();
  }

  //* handle the notification message
  void _handleMessage(RemoteMessage? message) {
    print(message?.notification?.title);
    print(message?.notification?.body);

    //* if the notification message have routeName then navigate to that page

    if (message != null) {
      LocalNotificationService.firePlay(message);
      String? _routeName = message.data['route'];
      if (_routeName != null) {
        Navigator.of(context).pushNamed(_routeName);
      }
    }
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
