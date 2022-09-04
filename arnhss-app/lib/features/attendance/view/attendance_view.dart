import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/attendance/widgets/attendance_calendar.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({Key? key}) : super(key: key);
  static const routeName = "/attendance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 72,
        centerTitle: true,
        leading: IconButton(
            splashRadius: 25,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
        title: const Text("Attendance",
            style: TextStyle(
                color: CustomColors.dark, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            AttendanceCalendar(),
          ],
        ),
      ),
    );
  }
}
