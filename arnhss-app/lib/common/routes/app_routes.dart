import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/role_wrapper.dart';
import 'package:arnhss/features/users/student/profile/view/profile_view.dart';

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
      // case UserRole.routeName:
      //   return MaterialPageRoute(builder: (_) => const UserRole());
      // case StudentAuthentication.routeName:
      //   return MaterialPageRoute(builder: (_) => const StudentAuthentication());
      case SelectAccount.routeName:
        return MaterialPageRoute(builder: (_) => const SelectAccount());
      case RoleWrapper.routeName:
        return MaterialPageRoute(builder: (_) => const RoleWrapper());
      case StudentHome.routeName:
        return MaterialPageRoute(builder: (_) => const StudentHome());
      case NoticeView.routeName:
        final NoticeModel args = settings.arguments as NoticeModel;
        return MaterialPageRoute(
          builder: (_) => NoticeView(
            notice: args,
          ),
        );
      case AttendanceView.routeName:
        return MaterialPageRoute(builder: (_) => const AttendanceView());
      case PlannerView.routeName:
        return MaterialPageRoute(builder: (_) => const PlannerView());
      case NotificationView.routeName:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case NotesView.routeName:
        return MaterialPageRoute(builder: (_) => const NotesView());
      case ProfileView.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case SelectedNoteView.routeName:
        final Subject sub = settings.arguments as Subject;
        return MaterialPageRoute(
            builder: (_) => SelectedNoteView(subject: sub));

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
