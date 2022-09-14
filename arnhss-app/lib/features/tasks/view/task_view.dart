import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/tasks/widgets/date_timline.dart';
import 'package:arnhss/features/tasks/widgets/floating_button.dart';
import 'package:arnhss/features/tasks/widgets/task_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: taskAppBar(context),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DateTimeline(),
                // NotFound(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Column(
                      children: const [
                        TaskTile(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const FloatingButton()
          ],
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
          color: CustomColors.lightBgOverlay,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "09:03 PM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: CustomColors.dark.withOpacity(.6),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "10:21 AM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: CustomColors.dark.withOpacity(.6),
                ),
              ),
              const SizedBox(height: 5),
              CircleAvatar(
                backgroundColor: CustomColors.bgOverlay,
                child: const Icon(Remix.time_line, color: CustomColors.light),
              )
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Home works on maths",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Lorem ipsume text is used for desgining purpose",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis,
                      color: CustomColors.dark.withOpacity(.6)),
                ),
                Row(
                  children: [
                    Chip(
                      label: const Text(
                        "#home-work",
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.orange.withOpacity(.2),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text(
                        "#home-work",
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.orange.withOpacity(.2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
