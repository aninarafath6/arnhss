import 'package:arnhss/models/student.model.dart';
import 'package:arnhss/models/teacher.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final DateTime date;
  final String id;
  // final AttendanceStatus status;
  final bool isANTaken;
  final bool isBFTaken;
  final TeacherModel? teacher;
  final List<StudentModel> AN;
  final List<StudentModel> BN;
  final DocumentReference? reference;

  AttendanceModel({
    required this.date,
    required this.isANTaken,
    required this.isBFTaken,
    this.teacher,
    required this.AN,
    required this.BN,
    this.reference,
    required this.id,
    // required thi
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      date: map["date"],
      isANTaken: map["isANTaken"],
      isBFTaken: map["isBFTaken"],
      teacher: map["teacher"],
      AN: map["AN"],
      BN: map["BN"],
      id: map["id"],
    );
  }

  Map<String, dynamic> toMap() => {
        "date": Timestamp.fromDate(date),
        "isANTaken": isANTaken,
        "isBNTaken": isBFTaken,
        "teacher": teacher?.reference,
        "AN": AN.map((e) => e.reference).toList(),
        "BN": BN.map((e) => e.reference).toList()
      };
}

// List<AttendanceModel> attendanceList = [
//   AttendanceModel(date: DateTime.now(), status: AttendanceStatus.absent),
//   AttendanceModel(
//       date: DateTime.utc(2022, 9, 8), status: AttendanceStatus.halfPresent),
// ];

enum AttendanceStatus {
  fullPresent,
  halfPresent,
  absent,
}
