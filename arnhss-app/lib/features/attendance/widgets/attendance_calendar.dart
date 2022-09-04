import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/attendance/view_model/attendance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(
            color: Colors.redAccent.withOpacity(.6),
          ),
          isTodayHighlighted: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.redAccent.withOpacity(1))),
        // headerStyle: HeaderStyle(
        //   leftChevronVisible: false,
        //   titleCentered: true,
        //   rightChevronVisible: false,
        //   formatButtonVisible: false,
        //   headerPadding: const EdgeInsets.only(bottom: 10),
        //   headerMargin: const EdgeInsets.only(bottom: 20),
        //   titleTextStyle: const TextStyle(color: Colors.black),
        //   decoration: BoxDecoration(
        //     color: CustomColors.lightBgOverlay,
        //     // borderRadius: BorderRadius.circular(5),
        //     borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(10),
        //       bottomLeft: Radius.circular(10),
        //     ),
        //   ),
        // ),
        onPageChanged: (date) =>
            context.read<AttendanceViewModel>().onPageChanged = date,
        daysOfWeekHeight: 50,
        headerVisible: false,
      ),
    );
  }
}
