import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/tasks/view_model/task_view_model.dart';
import 'package:arnhss/features/tasks/widgets/date_timline.dart';
import 'package:arnhss/features/tasks/widgets/floating_button.dart';
import 'package:arnhss/features/tasks/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DateTimeline(),
                NotFound(),
              ],
            ),
            const FloatingButton()
          ],
        ),
      ),
    );
  }
}
