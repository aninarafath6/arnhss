import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/attendance/view/attendance_view.dart';
import 'package:arnhss/features/users/student/attendance/widgets/attendance_app_bar.dart';
import 'package:arnhss/features/users/student/attendance/widgets/attendance_performance.dart';
import 'package:arnhss/features/users/view_model/attendance_view_model.dart';
import 'package:arnhss/features/users/widget/take_attendance_page.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:remixicon/remixicon.dart';

class AttendanceDetailView extends StatelessWidget {
  const AttendanceDetailView({Key? key}) : super(key: key);
  static const routeName = "/attendance_details";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: attendanceAppBar(context),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.default_padding),
        child: ListView(
          children: [
            Consumer<AttendanceViewModel>(builder: (context, provider, _) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CalendarCarousel<Event>(
                  height: context.getHeight(35),
                  weekendTextStyle: const TextStyle(
                    color: CustomColors.dark,
                  ),
                  selectedDateTime: provider.selectedDay,
                  onCalendarChanged: (day) {
                    return provider.onPageChanged = day;
                  },
                  selectedDayButtonColor: Colors.transparent,
                  onDayPressed: ((p0, p1) {
                    provider.setSelectedDay = p0;
                  }),
                  customDayBuilder: (isSelectable,
                      index,
                      isSelectedDay,
                      isToday,
                      isPrevMonthDay,
                      textStyle,
                      isNextMonthDay,
                      isThisMonthDay,
                      day) {
                    return provider.selectedDay == day
                        ? Center(
                            child: CircleAvatar(
                              child: Text(day.day.toString()),
                              backgroundColor:
                                  CustomColors.halfColor.withOpacity(.4),
                            ),
                          )
                        : isToday
                            ? Center(
                                child: CircleAvatar(
                                  child: Text(day.day.toString(),
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  backgroundColor:
                                      CustomColors.presentColor.withOpacity(.2),
                                ),
                              )
                            : null;
                  },
                  disableDayPressed: false,
                  weekDayMargin: const EdgeInsets.only(bottom: 14.0),
                  weekdayTextStyle: const TextStyle(color: CustomColors.dark),
                  showHeader: false,
                  todayButtonColor: Colors.transparent,
                  todayTextStyle: const TextStyle(color: CustomColors.dark),
                  pageSnapping: true,
                  pageScrollPhysics: const PageScrollPhysics(),
                  shouldShowTransform: true,
                ),
              );
            }),
            const AttendancePerformance(),
            const SizedBox(height: 30),
            CustomButton(
              label: "TAKE ATTENDANCE",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Please Select 😇.."),
                        content: Text(
                          "Please specify which attendance you will be taking",
                          style: CustomTextTheme(context: context)
                              .paragraph()
                              .copyWith(fontSize: 15),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context
                                    .read<AttendanceViewModel>()
                                    .setAttendanceTiming = AttendanceTimes.bn;
                                context
                                    .read<AttendanceViewModel>()
                                    .setAttendanceTiming = AttendanceTimes.bn;

                                Navigator.pop(context);
                              },
                              child: const Text(
                                "BEFORE NOON",
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AttendanceViewModel>()
                                  .setAttendanceTiming = AttendanceTimes.an;
                              Navigator.pop(context);
                            },
                            child: "AFTER NOON".toText(
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                      );
                    }).then((value) async {
                  await Future.delayed(const Duration(milliseconds: 200));
                  Navigator.of(context).pushNamed(
                    TakeAttendancePage.routeName,
                  );
                });
              },
              elevation: false,
            ),
          ],
        ),
      ),
    );
  }
}
