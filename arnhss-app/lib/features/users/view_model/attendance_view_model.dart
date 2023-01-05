import 'package:arnhss/features/users/repo/attendance_service.dart';
import 'package:arnhss/features/users/student/attendance/model/attendance_model.dart';
import 'package:arnhss/models/student.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceService _attendanceService = AttendanceService();
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
  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  AttendanceTimes get attendanceTiming => _attendanceTimes;

  List<StudentModel> presentStudents = [];
  AttendanceTimes _attendanceTimes = AttendanceTimes.bn;

  set setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  set onPageChanged(DateTime date) {
    selectedPage = _months[date.month - 1] + " " + date.year.toString();
    notifyListeners();
  }

  set setAttendanceTiming(AttendanceTimes time) {
    _attendanceTimes = time;
  }

  void resetPage() {
    selectedPage = initialPage;
    notifyListeners();
  }

  void togglePresentSelection(StudentModel student) {
    if (presentStudents.contains(student)) {
      presentStudents.remove(student);
    } else {
      presentStudents.add(student);
    }
    notifyListeners();
  }

  List<StudentModel> onSubmitAn(List<StudentModel> totalStudents) {
    List<StudentModel> allStudents = totalStudents;
    List<StudentModel> items = allStudents
        .where((element) => !presentStudents.contains(element))
        .toList();
    return items;
  }

  onStart(DocumentReference batchRef, List<StudentModel> allStudents) async {
    print("started ...");
    List<StudentModel> absentees =
        await _attendanceService.alreadyTakenStudentsBN(batchRef, selectedDay);
    presentStudents.addAll(allStudents);
    presentStudents.removeWhere(((element) => absentees.contains(element)));

    notifyListeners();
  }

  void onProceed(DocumentReference batchRef, List<StudentModel> absentees) {
    AttendanceModel attendance = AttendanceModel(
        date: selectedDay,
        isANTaken: attendanceTiming == AttendanceTimes.an,
        isBFTaken: attendanceTiming == AttendanceTimes.bn,
        AN: attendanceTiming == AttendanceTimes.an ? absentees : [],
        BN: attendanceTiming == AttendanceTimes.bn ? absentees : [],
        id: "id");

    _attendanceService.takeAttendance(batchRef, attendance);
  }
}

enum AttendanceTimes { an, bn }
