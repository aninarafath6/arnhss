import 'package:arnhss/features/users/view_model/attendance_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/home/view_models/home_view_model.dart';
import 'package:arnhss/features/users/student/planner/view_model/planner_view_model.dart';

class Providers {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => CountryViewModel()),
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => VerifyOtpViewModel()),
      ChangeNotifierProvider(create: (_) => StudentHomeViewModel()),
      ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
      ChangeNotifierProvider(create: (_) => PlannerViewModel()),
    ];
  }
}
