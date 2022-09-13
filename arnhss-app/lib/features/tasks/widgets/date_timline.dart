import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/tasks/view_model/task_view_model.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
