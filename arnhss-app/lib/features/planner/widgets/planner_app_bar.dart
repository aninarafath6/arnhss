import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/view_model/task_view_model.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

AppBar taskAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      splashRadius: 28,
      icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark),
    ),
    title: const Text(
      "Planner",
      style: TextStyle(color: CustomColors.dark),
    ),
    actions: [
      IconButton(
        splashRadius: 20,
        tooltip: 'selected day',
        onPressed: () {
          context.read<TaskViewModel>().toToday();
        },
        icon: Icon(
          Remix.focus_2_line,
          color: CustomColors.dark.withOpacity(.5),
        ),
      )
    ],
  );
}
