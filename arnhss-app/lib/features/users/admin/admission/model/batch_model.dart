// ignore_for_file: non_constant_identifier_names

import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Batch {
  final String id;
  late final int code;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String courseId;
  final TeacherModel teacher;
  final StudentModel? leader;
  final DocumentReference? reference;
  Batch({
    required this.name,
    required this.code,
    required this.id,
    required this.endDate,
    required this.startDate,
    required this.courseId,
    required this.teacher,
    this.reference,
    this.leader,
  });

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
        "start_date": Timestamp.fromDate(startDate),
        "end_date": Timestamp.fromDate(endDate),
        "teacher": teacher.reference,
        "leader": leader?.reference,
      };

  factory Batch.fromMap(Map<String, dynamic> batchMap) {
    Timestamp _startDate = batchMap["start_date"] as Timestamp;
    Timestamp _endDate = batchMap["end_date"] as Timestamp;

    return Batch(
      id: batchMap["id"],
      name: batchMap["name"].toString().toUpperCase(),
      code: int.parse(batchMap["code"].toString()),
      startDate: _startDate.toDate(),
      endDate: _endDate.toDate(),
      courseId: batchMap["course_id"],
      teacher: batchMap["teacher"],
      leader: batchMap["leader"],
      reference: batchMap["reference"],
    );
  }
}
