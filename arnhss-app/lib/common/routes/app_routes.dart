import 'package:arnhss/features/authentication/login/view/login.dart';
import 'package:arnhss/features/onboarding/views/onboarding_view.dart';
import 'package:arnhss/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case SplashView.routeName:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case LoginView.routeName:
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
