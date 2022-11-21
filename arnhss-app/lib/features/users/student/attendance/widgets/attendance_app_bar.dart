import 'package:arnhss/features/users/student/attendance/view_model/attendance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      Center(
        child: Consumer<AttendanceViewModel>(builder: (context, value, child) {
          return Text(
            value.selectedPage,
            style: const TextStyle(
              color: CustomColors.light,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(width: 20),
    ],
  );
}
