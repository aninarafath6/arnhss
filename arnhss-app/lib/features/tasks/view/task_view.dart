import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [],
                ),
                Container(
                  height: 60,
                  child: HorizontalCalendar(
                    date: DateTime.now(),
                    textColor: Colors.black45,
                    backgroundColor: Colors.green,
                    selectedColor: CustomColors.dark,
                    onDateSelected: (date) => print(
                      date.toString(),
                    ),
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
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
