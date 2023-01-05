import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/users/view_model/attendance_view_model.dart';
import 'package:arnhss/features/users/widget/take_attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../../common/constants/color_constants.dart';

AppBar attendanceAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: CustomColors.white,
    elevation: 0,
    leadingWidth: 72,
    centerTitle: false,
    leading: IconButton(
        splashRadius: 25,
        onPressed: () {
          Navigator.pop(context);
          context.read<AttendanceViewModel>().resetPage();
        },
        icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
    title: const Text(
      "Attendance",
      style: TextStyle(color: CustomColors.dark, fontWeight: FontWeight.bold),
    ),
    actions: [
      // Center(
      //   child: Container(
      //     // width: 100,
      //     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //     color: CustomColors.bgOverlay,
      //     child: TextButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed(TakeAttendancePage.routeName);
      //       },
      //       child: Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             const Icon(Remix.checkbox_circle_line),
      //             const SizedBox(width: 10),
      //             Text(
      //               "Take ATT",
      //               style:
      //                   CustomTextTheme(context: context).headLine2().copyWith(
      //                         fontSize: 12,
      //                         fontWeight: FontWeight.w500,
      //                       ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      Center(
        child: Consumer<AttendanceViewModel>(
          builder: (context, value, child) {
            return Text(
              value.selectedPage,
              style: const TextStyle(
                color: CustomColors.light,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
      ),
      const SizedBox(width: 20),
    ],
  );
}
