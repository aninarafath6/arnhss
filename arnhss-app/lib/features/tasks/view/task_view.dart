import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/tasks/view_model/task_view_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
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
              children: [
                const DateTimeline(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Container(
                        // height: 350,
                        width: 250,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.asset(Images.notFound),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "No plans for this day",
                        style: CustomTextTheme(context: context).headLine2(),
                      ),
                      const SizedBox(height: 10),
                      // Text(
                      //   "looks like you haven't made your plans yet",
                      //   style: CustomTextTheme(context: context).paragraph(),
                      //   textAlign: TextAlign.center,
                      // ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: TextButton(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.dark,
                  ),
                  child: const Icon(Remix.add_fill, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeline extends StatelessWidget {
  const DateTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21.0),
      child: DatePicker(
        DateTime.now(),
        controller: context.read<TaskViewModel>().dateController,
        initialSelectedDate: context.watch<TaskViewModel>().selectedDate,
        selectionColor: CustomColors.dark,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          context.read<TaskViewModel>().setSelectedDate = date;
        },
      ),
    );
  }
}
