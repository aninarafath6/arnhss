import 'package:arnhss/fetures/onboarding/views/onboarding_view.dart';
import 'package:arnhss/fetures/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case SplashView.routeName:
        return MaterialPageRoute(builder: (_) => const SplashView());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
