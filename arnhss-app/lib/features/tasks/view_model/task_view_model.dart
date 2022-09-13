import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier {
  final DatePickerController _timelineController = DatePickerController();
  DateTime _selectedDate = DateTime.now();

  DatePickerController get dateController => _timelineController;
  DateTime get selectedDate => _selectedDate;

  set setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void toToday() {
    // _timelineController.animateToDate(DateTime.now(),
    //     duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
    _selectedDate = DateTime.now();
    notifyListeners();
  }
}
