import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/views/add_teacher_to_course_view.dart';
import 'package:arnhss/features/users/admin/admission/views/admission_view.dart';
import 'package:arnhss/features/users/admin/admission/views/batches_view.dart';
import 'package:arnhss/features/users/admin/admission/views/course_view.dart';
import 'package:arnhss/features/users/admin/admission/views/student_list.dart';
import 'package:arnhss/features/users/admin/admission/views/single_batch_view.dart';
import 'package:arnhss/features/users/admin/admission/views/teacher_list.dart';
import 'package:arnhss/features/users/admin/home.admin/views/all_teacher.dart';
import 'package:arnhss/features/users/admin/home.admin/views/notice.view.admin.dart';
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
      case StudentList.routeName:
        return MaterialPageRoute(builder: (_) => const StudentList());
      case TeacherList.routeName:
        return MaterialPageRoute(builder: (_) => const TeacherList());
      case AllTeacherListView.routeName:
        return MaterialPageRoute(builder: (_) => const AllTeacherListView());
      case AddTeacherToCourseView.routeName:
        return MaterialPageRoute(
            builder: (_) => const AddTeacherToCourseView());
      case NoticeView.routeName:
        return MaterialPageRoute(builder: (_) => const NoticeView());
      case AdmissionView.routeName:
        return MaterialPageRoute(builder: (_) => const AdmissionView());
      case CourseView.routeName:
        return MaterialPageRoute(builder: (_) {
          // final Course args = settings.arguments as Course;
          return const CourseView();
        });
      case SingleBatchView.routeName:
        return MaterialPageRoute(builder: (_) {
          return const SingleBatchView();
        });

      case SelectAccount.routeName:
        return MaterialPageRoute(builder: (_) => const SelectAccount());
      case BatchesView.routeName:
        return MaterialPageRoute(
          builder: (_) {
            final Course _selectedCourse = settings.arguments as Course;
            return BatchesView(selectedCourse: _selectedCourse);
          },
        );
      case RoleWrapper.routeName:
        return MaterialPageRoute(builder: (_) => const RoleWrapper());
      case StudentHome.routeName:
        return MaterialPageRoute(builder: (_) => const StudentHome());
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
