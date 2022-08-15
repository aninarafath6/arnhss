import 'package:arnhss/features/authentication/login/view/login.dart';
import 'package:arnhss/features/authentication/login/widgets/country_select.dart';
import 'package:arnhss/features/authentication/otp_verification/view/otp_verify_view.dart';
import 'package:arnhss/features/authentication/user_role/views/user_role.dart';
import 'package:arnhss/features/onboarding/view/onboarding_view.dart';
import 'package:arnhss/features/splash/views/splash_view.dart';
import 'package:arnhss/features/users/students/authentication/view/student_authentication.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case SplashView.routeName:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case LoginView.routeName:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case OtpVerificationView.routeName:
        return MaterialPageRoute(builder: (_) => const OtpVerificationView());
      case CountrySelect.routeName:
        return MaterialPageRoute(builder: (_) => CountrySelect());
      case UserRole.routeName:
        return MaterialPageRoute(builder: (_) => const UserRole());
      case StudentAuthencation.routeName:
        return MaterialPageRoute(builder: (_) => const StudentAuthencation());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
