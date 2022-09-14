import 'package:arnhss/features/tasks/models/task_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class TaskViewModel extends ChangeNotifier {
  final DatePickerController _timelineController = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  bool _loading = false;

  List<TaskModel> takList = [
    TaskModel(
      title: "Maths home work",
      note: "text dummy text for display ",
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(minutes: 200)),
    )
  ];

  DatePickerController get dateController => _timelineController;
  DateTime get selectedDate => _selectedDate;
  bool get loading => _loading;

  set setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void toToday() {
    _timelineController.animateToSelection(curve: Curves.easeInOutCubic);
    _selectedDate = DateTime.now();
    notifyListeners();
  }

  Future<List<TaskModel>> getTasksOfTheDay(DateTime date) async {
    _loading = true;
    await Future.delayed(const Duration(seconds: 1));
    return takList;
  }
}
