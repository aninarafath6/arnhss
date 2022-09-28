import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class PlannerModel {
  final String? title;
  // final String? subTitle;
  final TimeOfDay? time;
  // final DateTime? endTime;
  final DateTime? date;
  final String? note;
  final String? subject;
  final String? type;
  final bool? isCompleted;

  PlannerModel({
    this.title,
    // this.subTitle,
    this.time,
    // this.endTime,
    this.date,
    this.note,
    this.subject,
    this.type,
    this.isCompleted,
  });
}
