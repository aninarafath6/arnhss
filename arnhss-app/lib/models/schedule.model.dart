import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/subject_model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Schedule {
  final String day;
  final List<Period> schedule;
  final DocumentReference? reference;
  final String id;

  Schedule({
    required this.id,
    required this.day,
    required this.schedule,
    this.reference,
  });

  factory Schedule.fromMap(Map<String, dynamic> map) {
    List _schedule = map["schedule"];

    return Schedule(
      id: map["id"],
      day: map["day"],
      reference: map["reference"],
      schedule: _schedule.map((e) {
        return Period.fromMap(e);
      }).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        "day": day,
        "schedule": schedule.map((e) {
          return e.toMap();
        }).toList(),
      };
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
  DateTime now = DateTime.now();

  Map<String, dynamic> toMap() => {
        "teacher": teacher.reference,
        "subject": subject.reference,
        "period_name": name,
        "end_time": Timestamp.fromDate(
          DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute),
        ),
        "start_time": Timestamp.fromDate(
          DateTime(
              now.year, now.month, now.day, startTime.hour, startTime.minute),
        ),
      };
}
