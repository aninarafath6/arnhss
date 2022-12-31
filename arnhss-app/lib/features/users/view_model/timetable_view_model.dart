import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/repo/timetable_service.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableViewModel extends ChangeNotifier {
  final TimeTableService _timeTableService = TimeTableService();

  bool _loading = false;
  final List<Schedule> _schedule = [];

  //* getters
  get loading => _loading;
  get schedule => _schedule;

  void getTimeTableOfDay({
    required DocumentReference batchRef,
    required String day,
  }) async {
    _loading = true;
    List<Schedule>? scheduleOfDay =
        await _timeTableService.getTimeTableOfDay(batchRef, day);
    _schedule.clear();
    _schedule.addAll(scheduleOfDay ?? []);

    _loading = false;
  }
}
