import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';

class DateTimeline<T> extends StatefulWidget {
  const DateTimeline({
    Key? key,
    this.onDateChange,
    this.initialSelectedDate,
    required this.controller,
    this.selectDate,
    required this.init,
  }) : super(key: key);
  final Function(DateTime)? onDateChange;
  final DatePickerController controller;
  final DateTime? initialSelectedDate;
  final DateTime? selectDate;
  final Function() init;

  @override
  State<DateTimeline<T>> createState() => _DateTimelineState<T>();
}

class _DateTimelineState<T> extends State<DateTimeline<T>> {
  @override
  void initState() {
    // widget.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.init());

    return Padding(
      padding: const EdgeInsets.only(left: 21.0),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 300)),
        controller: widget.controller,
        initialSelectedDate: widget.selectDate,
        selectionColor: CustomColors.dark,
        selectedTextColor: Colors.white,
        onDateChange: widget.onDateChange,
        select: widget.selectDate,
      ),
    );
  }
}
