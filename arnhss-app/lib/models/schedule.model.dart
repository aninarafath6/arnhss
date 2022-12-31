import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/subject_model.dart';
import 'package:arnhss/features/users/admin/admission/repo/admission_service.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String day;
  final List<Period> schedule;

  Schedule({
    required this.day,
    required this.schedule,
  });

  factory Schedule.fromMap(Map<String, dynamic> map) {
    List _schedule = map["schedule"];

    return Schedule(
      day: map["day"],
      schedule: _schedule.map((e) {
        return Period.fromMap(e);
        // Period.fromMap(e);

        // return "hi";
      }).toList(),
    );
  }
}

class Period {
  final TeacherModel teacher;
  final SubjectModel subject;
  final int name;
  final TimeOfDay endTime;
  final TimeOfDay startTime;

  Period({
    required this.teacher,
    required this.subject,
    required this.name,
    required this.endTime,
    required this.startTime,
  });

  factory Period.fromMap(Map map) {
    // print(map["teacher"]);
    Timestamp endTime = map['end_time'];
    Timestamp startTime = map['start_time'];

    return Period(
      teacher: TeacherModel.fromMap(map["teacher"]),
      subject: SubjectModel.fromMap(map["subject"]),
      name: map["period_name"],
      endTime: TimeOfDay.fromDateTime(endTime.toDate()),
      startTime: TimeOfDay.fromDateTime(startTime.toDate()),
    );
  }
}
