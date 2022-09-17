import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
import 'package:arnhss/features/planner/view_model/planner_view.dart';
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
        controller: context.read<PlannerViewModel>().dateController,
        initialSelectedDate: context.watch<PlannerViewModel>().selectedDate,
        selectionColor: CustomColors.dark,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          context.read<PlannerViewModel>().setSelectedDate = date;
        },
        select: context.watch<PlannerViewModel>().selectedDate,
      ),
    );
  }
}
