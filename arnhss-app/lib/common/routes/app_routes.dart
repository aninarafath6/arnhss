import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/notes/model/department_mode.dart';
import 'package:arnhss/features/notes/view/notes_view.dart';
import 'package:arnhss/features/notes/view/selected_note_view.dart';
import 'package:arnhss/features/notifications/view/notification_view.dart';
import 'package:arnhss/features/splash/views/wrapper.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case SplashView.routeName:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Wrapper.routeName:
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case LoginView.routeName:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case OtpVerificationView.routeName:
        return MaterialPageRoute(builder: (_) => const OtpVerificationView());
      case CountrySelect.routeName:
        return MaterialPageRoute(builder: (_) => CountrySelect());

      // case StudentAuthentication.routeName:
      //   return MaterialPageRoute(builder: (_) => const StudentAuthentication());
      case SelectAccount.routeName:
        return MaterialPageRoute(builder: (_) => const SelectAccount());
      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => const HomeView());
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
      case SelectedNoteView.routeName:
        final Subject sub = settings.arguments as Subject;
        return MaterialPageRoute(
            builder: (_) => SelectedNoteView(subject: sub));
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
