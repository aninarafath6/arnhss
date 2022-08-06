import 'package:arnhss/fetures/onboarding/views/onbaording_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
