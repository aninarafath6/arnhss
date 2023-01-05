import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/common/widgets/student_tile.dart';
import 'package:arnhss/extensions/dt_extension.dart';
import 'package:arnhss/extensions/enum_extension.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/students_view_model.dart';
import 'package:arnhss/features/users/view_model/attendance_view_model.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:shimmer/shimmer.dart';

class TakeAttendancePage extends StatefulWidget {
  const TakeAttendancePage({Key? key}) : super(key: key);
  static const String routeName = "/take_attendance_page";

  @override
  State<TakeAttendancePage> createState() => _TakeAttendancePageState();
}

class _TakeAttendancePageState extends State<TakeAttendancePage>
    with TickerProviderStateMixin {
  late TabController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context
            .read<StudentViewModel>()
            .getStudents(context.read<BatchViewModel>().selectedBatch);
        context.read<AttendanceViewModel>().onStart(
            context.read<BatchViewModel>().selectedBatch.reference!,
            context.read<StudentViewModel>().students);
      },
    );
  }

  double _getTheHeight(int length) {
    if (length == 0) {
      return 80;
    } else if (length <= 3) {
      return 65;
    } else {
      return 95;
    }
  }

  @override
  Widget build(BuildContext context) {
    String attendanceTiming = context
        .watch<AttendanceViewModel>()
        .attendanceTiming
        .fancy
        .toUpperCase();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Take Attendance ($attendanceTiming)",
          style: CustomTextTheme(context: context)
              .headLine()
              .copyWith(fontSize: 20),
        ),
        centerTitle: false,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.dark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Text(
              context
                  .read<AttendanceViewModel>()
                  .selectedDay
                  .dtFrm(e: "", d: "dd", m: "/MM", y: "/yyyy"),
              style: const TextStyle(color: CustomColors.texty),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 21, right: 21),
        child: Consumer2<StudentViewModel, AttendanceViewModel>(
            builder: (context, provider, attendanceProvider, child) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 60,
                    childAspectRatio: 5 / 5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: provider.loading ? 65 : provider.students.length,
                  itemBuilder: ((context, index) {
                    bool isSelectedItem = false;
                    if (!provider.loading) {
                      isSelectedItem = attendanceProvider.presentStudents
                          .contains(provider.students[index]);
                    }
                    return provider.loading
                        ? Shimmer.fromColors(
                            baseColor: CustomColors.bgOverlay,
                            highlightColor: CustomColors.light.withOpacity(.5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColors.lightBgOverlay,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () =>
                                attendanceProvider.togglePresentSelection(
                                    provider.students[index]),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: isSelectedItem
                                    ? CustomColors.presentColor.withOpacity(.5)
                                    : CustomColors.lightBgOverlay,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  provider.students[index].rollNumber
                                      .toString(),
                                ),
                              ),
                            ),
                          );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9.0,
                  vertical: 10,
                ),
                child: CustomButton(
                  label: "Submit",
                  onTap: () {
                    List<StudentModel> _absentees = context
                        .read<AttendanceViewModel>()
                        .onSubmitAn(context.read<StudentViewModel>().students);
                    showModalBottomSheet(
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                      isScrollControlled: true,
                      context: context,
                      builder: ((context) {
                        return Container(
                          height: context
                              .getHeight(_getTheHeight(_absentees.length)),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: CustomColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 100,
                                  height: 4,
                                  decoration: BoxDecoration(
                                      color: CustomColors.bgOverlay,
                                      borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Stack(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "EDIT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: CustomColors.light),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "($attendanceTiming) ABSENTEES",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: CustomColors.dark),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _absentees.isEmpty
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50.0, vertical: 20),
                                            child: Image.asset(
                                                "assets/images/icons/thumb-up.png"),
                                          ),
                                          Text(
                                            "Well Done!  Absents free day🥳",
                                            style: CustomTextTheme(
                                                    context: context)
                                                .paragraph()
                                                .copyWith(
                                                    color: CustomColors.dark
                                                        .withOpacity(.8),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "Congratulations on a successful class with perfect attendance! Your dedication to teaching is inspiring. Keep up the great work!",
                                            style: CustomTextTheme(
                                                    context: context)
                                                .paragraph()
                                                .copyWith(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return StudentTile(
                                              student: _absentees[index]);
                                        },
                                        itemCount: _absentees.length,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CustomButton(
                                  label: "Proceed",
                                  onTap: () {
                                    context
                                        .read<AttendanceViewModel>()
                                        .onProceed(
                                            context
                                                .read<BatchViewModel>()
                                                .selectedBatch
                                                .reference!,
                                            _absentees);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),

      // resizeToAvoidBottomInset: true,
      extendBody: false,
    );
  }
}
