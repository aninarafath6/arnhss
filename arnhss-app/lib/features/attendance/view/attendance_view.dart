import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/attendance/view_model/attendance_view_model.dart';
import 'package:arnhss/features/attendance/widgets/attendance_calendar.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:pie_chart/pie_chart.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({Key? key}) : super(key: key);
  static const routeName = "/attendance";

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  Map<String, double> dataMap = {
    "Present": 5,
    "Absent": 3,
    "Late": 2,
  };
  AttendanceViewModel attendanceViewModel = AttendanceViewModel();

  @override
  void initState() {
    // attendanceViewModel.();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        elevation: 0,
        leadingWidth: 72,
        centerTitle: false,
        leading: IconButton(
            splashRadius: 25,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
        title: const Text(
          "Attendance",
          style:
              TextStyle(color: CustomColors.dark, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: Text(
              context.watch<AttendanceViewModel>().selectedPage,
              style: const TextStyle(
                color: CustomColors.light,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const AttendanceCalendar(),
            Container(
              padding: EdgeInsets.all(21),
              decoration: BoxDecoration(
                  color: CustomColors.lightBgOverlay,
                  borderRadius: BorderRadius.circular(
                    5,
                  )),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
