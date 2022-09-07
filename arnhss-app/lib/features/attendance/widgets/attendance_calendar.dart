import 'dart:math';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/attendance/view_model/attendance_view_model.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

class AttendanceCalendar extends StatelessWidget {
  AttendanceCalendar({
    Key? key,
  }) : super(key: key);

  final List<DateTime> halfPresent = [
    DateTime(2022, 9, 1),
    DateTime(2022, 9, 30),
    DateTime(2022, 9, 11),
  ];
  List<DateTime> absentDates = [
    DateTime(2022, 9, 2),
    DateTime(2022, 9, 7),
    DateTime(2022, 9, 8),
    DateTime(2022, 9, 21),
  ];

  static Widget _presentIcon(String day) => Stack(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
          ),
          CircleAvatar(
            backgroundColor: CustomColors.halfColor.withOpacity(.2),
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
  static Widget _absentIcon(String day) => Stack(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
          ),
          CircleAvatar(
            backgroundColor: CustomColors.absentColor.withOpacity(.2),
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  late var len = min(absentDates.length, halfPresent.length);
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        halfPresent[i],
        Event(
          date: halfPresent[i],
          title: 'Event 5',
          icon: _presentIcon(
            halfPresent[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        Event(
          date: absentDates[i],
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }
    return Container(
      // height: context.getHeight(40),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: CalendarCarousel<Event>(
        height: context.getHeight(33),
        weekendTextStyle: const TextStyle(
          color: Colors.black,
        ),
        weekDayMargin: const EdgeInsets.only(bottom: 14.0),
        weekdayTextStyle: const TextStyle(color: Colors.black),
        showHeader: false,
        todayButtonColor: Colors.transparent,
        todayTextStyle: const TextStyle(color: Colors.black),
        markedDatesMap: _markedDateMap,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        onCalendarChanged: (date) =>
            context.read<AttendanceViewModel>().onPageChanged = date,
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        pageSnapping: true,
        pageScrollPhysics: const BouncingScrollPhysics(),
        shouldShowTransform: false,
      ),
    );
  }
}
