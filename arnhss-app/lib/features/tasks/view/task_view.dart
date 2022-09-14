import 'package:arnhss/features/tasks/widgets/date_timline.dart';
import 'package:arnhss/features/tasks/widgets/floating_button.dart';
import 'package:arnhss/features/tasks/widgets/task_app_bar.dart';
import 'package:arnhss/features/tasks/widgets/task_tile/task_tile.dart';
import 'package:flutter/material.dart';

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
