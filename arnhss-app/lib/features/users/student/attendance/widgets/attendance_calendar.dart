import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/users/student/attendance/view_model/attendance_view_model.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
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
    DateTime(2022, 9, 26),
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
                color: CustomColors.dark,
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
                color: CustomColors.dark,
              ),
            ),
          ),
        ],
      );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < halfPresent.length; i++) {
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

    for (int i = 0; i < absentDates.length; i++) {
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

    return Consumer<AttendanceViewModel>(builder: (context, value, child) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: CalendarCarousel<Event>(
          height: context.getHeight(34) < 280 ? 280 : context.getHeight(34),
          weekendTextStyle: const TextStyle(
            color: CustomColors.dark,
          ),
          disableDayPressed: true,
          weekDayMargin: const EdgeInsets.only(bottom: 14.0),
          weekdayTextStyle: const TextStyle(color: CustomColors.dark),
          showHeader: false,
          todayButtonColor: Colors.transparent,
          todayTextStyle: const TextStyle(color: CustomColors.dark),
          markedDatesMap: _markedDateMap,
          markedDateShowIcon: true,
          markedDateIconMaxShown: 1,
          onCalendarChanged: (date) => value.onPageChanged = date,
          markedDateIconBuilder: (event) {
            return event.icon;
          },
          pageSnapping: false,
          pageScrollPhysics: const BouncingScrollPhysics(),
          shouldShowTransform: false,
        ),
      );
    });
  }
}
