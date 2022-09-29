import 'package:arnhss/common/widgets/date_picker/date_picker_widget.dart';
// import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:flutter/material.dart';

class PlannerViewModel extends ChangeNotifier {
  final DatePickerController _timelineController = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  bool _loading = false;
  final PageController _pageController =
      PageController(initialPage: DateTime.now().day);

  // List<PlannerModel> takList = [
  //   PlannerModel(
  //     title: "Maths home work",
  //     note: "text dummy text for display ",
  //     startTime: DateTime.now(),
  //     endTime: DateTime.now().add(const Duration(minutes: 200)),
  //   ),
  //   PlannerModel(
  //     title: "Maths home work",
  //     note: "text dummy text for display ",
  //     startTime: DateTime.now(),
  //     endTime: DateTime.now().add(const Duration(minutes: 200)),
  //   ),
  // ];

  DatePickerController get dateController => _timelineController;
  DateTime get selectedDate => _selectedDate;
  bool get loading => _loading;
  PageController get pageController => _pageController;

  set setSelectedDate(DateTime date) {
    _selectedDate = date;
    _pageController.animateToPage(
      date.day,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 800),
    );
    notifyListeners();
  }

  void toToday() {
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
  }

  // Future<List<PlannerModel>> getTasksOfTheDay(DateTime date) async {
  //   _loading = true;
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   return ;
  // }

  void swipePage(int day) {
    // DateTime newDate = DateTime(_selectedDate.year, _selectedDate.month, day);

    // _timelineController.change(
    //     DateTime(_selectedDate.year, _selectedDate.month, day),
    //     Curves.easeInOut,
    //     const Duration(seconds: 1),
    //     _selectedDate.day);
    // // _timelineController.animateToSelection();\

    // setSelectedDate = newDate;
  }
}
