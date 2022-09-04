import 'dart:math';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 30),
        focusedDay: DateTime.now(),
        calendarStyle: const CalendarStyle(
          weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          isTodayHighlighted: false,
        ),
        headerStyle: HeaderStyle(
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
          headerPadding: const EdgeInsets.all(18),
          titleTextStyle: const TextStyle(color: Colors.black),
          decoration: BoxDecoration(
            color: CustomColors.lightBgOverlay,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        daysOfWeekHeight: 50,
        headerVisible: true,
      ),
    );
  }
}
