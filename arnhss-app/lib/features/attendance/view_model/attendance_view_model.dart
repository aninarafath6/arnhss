import 'package:flutter/material.dart';

class AttendanceViewModel extends ChangeNotifier {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  late String initialPage =
      _months[DateTime.now().month - 1] + " " + DateTime.now().year.toString();
  late String selectedPage = initialPage;

  set onPageChanged(DateTime date) {
    selectedPage = _months[date.month - 1] + " " + date.year.toString();
    notifyListeners();
    print(selectedPage);
  }

  void resetPage() {
    selectedPage = initialPage;
    notifyListeners();
  }
}
