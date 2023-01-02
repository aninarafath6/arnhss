import 'package:arnhss/common/routes/index_routes.dart';
// import 'package:arnhss/features/users/admin/admission/model/subject_model.dart';
import 'package:arnhss/features/users/repo/timetable_service.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableViewModel extends ChangeNotifier {
  final TimeTableService _timeTableService = TimeTableService();
  int selectedIndex = 0;
  List<String> workingDays = ["M", "T", "W", "TH", "F"];

  TeacherModel? teacher;
  // SubjectModel? subject;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool addLoading = false;

  bool _loading = false;
  Schedule? _schedule;
  final List<Schedule> _allSchedule = [];

  //* getters
  bool get loading => _loading;
  List<Schedule> get allSchedule => _allSchedule;
  Schedule? get schedule => _schedule;

  toggleLoading() {
    _loading = !_loading;
    notifyListeners();
  }

  toggleAddLoading() {
    addLoading = !addLoading;
    notifyListeners();
  }

  set setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool validate() {
    try {
      if (teacher == null) {
        throw InvalidException(
            "Please select teacher for this schedule.", false);
      }
      // else if (subject == null) {
      //   throw InvalidException(
      //       "Please select subject for this schedule.", false);
      // }
      else if (startTime == null) {
        throw InvalidException(
            "Please select start time for this schedule.", false);
      } else if (endTime == null) {
        throw InvalidException(
            "Please select end time for this schedule.", false);
      } else {
        return true;
      }
    } catch (e) {
      HandleException().handleException(e, top: true);
      return false;
    }
  }

  void getTimeTable({required DocumentReference batchRef}) async {
    _schedule = null;
    toggleLoading();
    List<Schedule>? scheduleOfDay =
        await _timeTableService.getTimeTableOfDay(batchRef);
    _allSchedule.clear();
    _allSchedule.addAll(scheduleOfDay ?? []);
    if (_allSchedule.isNotEmpty) {
      if (_allSchedule
          .where((element) => element.day == workingDays[selectedIndex])
          .isNotEmpty) {
        _schedule = _allSchedule
            .firstWhere((element) => element.day == workingDays[selectedIndex]);
      } else {
        _schedule == null;
      }
    }
    toggleLoading();
  }

  void getScheduleOfDay() async {
    print(allSchedule.length);
    // var res = _allSchedule.firstWhere((element) => element.day == day);
    _schedule = null;
    var res = _allSchedule.where(
      ((element) {
        return element.day == workingDays[selectedIndex];
      }),
    ).toList();
    if (res.isEmpty) {
      _schedule = null;
    } else {
      _schedule = res[0];
    }
    toggleLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    toggleLoading();

    notifyListeners();
  }

  void addSchedule(
      int index, DocumentReference batchRef, Function() callback) async {
    bool isValid = validate();

    if (isValid) {
      Period newPeriod = Period(
        teacher: teacher!,
        subject: teacher!.subject,
        name: index + 1,
        endTime: endTime!,
        startTime: startTime!,
      );

      if (schedule != null && !loading) {
        _schedule?.schedule.add(newPeriod);
        toggleAddLoading();
        await _timeTableService
            .updateSchedule(
          _schedule!,
          reference: schedule!.reference!,
        )
            .then((value) {
          callback();
          clearControllers();
        });
        toggleAddLoading();
      } else {
        // _schedule?.schedule.add(newPeriod);
        Schedule newSchedule = Schedule(
          id: "id",
          day: workingDays[selectedIndex],
          schedule: [newPeriod],
        );
        toggleAddLoading();
        await _timeTableService
            .createSchedule(
          newSchedule,
          reference: batchRef,
        )
            .then((value) {
          var nSchedule = Schedule(
              day: newSchedule.day,
              id: value?.id ?? "",
              schedule: newSchedule.schedule,
              reference: value);
          _schedule = nSchedule;
          callback();
          clearControllers();
        });
        toggleAddLoading();
      }
    } else {
      print("may be loading is true or its not valid inputs");
    }
  }

  void clearControllers() {
    teacher = null;
    endTime = null;
    startTime = null;
  }
}
