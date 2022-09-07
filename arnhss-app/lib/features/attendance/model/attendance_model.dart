class AttendanceModel {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceModel({
    required this.date,
    required this.status,
  });
}

List<AttendanceModel> attendanceList = [
  AttendanceModel(date: DateTime.now(), status: AttendanceStatus.absent),
  AttendanceModel(
      date: DateTime.utc(2022, 9, 8), status: AttendanceStatus.halfPresent),
];

enum AttendanceStatus {
  fullPresent,
  halfPresent,
  absent,
}
