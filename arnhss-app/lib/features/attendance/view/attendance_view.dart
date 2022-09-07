import 'package:arnhss/features/attendance/widgets/attendance_app_bar.dart';
import 'package:arnhss/features/attendance/widgets/attendance_calendar.dart';
import 'package:arnhss/features/attendance/widgets/attendance_performance.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({Key? key}) : super(key: key);
  static const routeName = "/attendance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: attendanceAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, right: 24, left: 24),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            AttendanceCalendar(),
            const SizedBox(height: 20),
            AttendancePerformance(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
