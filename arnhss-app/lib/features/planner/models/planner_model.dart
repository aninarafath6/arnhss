import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class PlannerModel {
  final String? id;
  final String? title;

  final TimeOfDay? time;

  final DateTime? date;
  final String? note;
  final String? subject;
  final String? type;
  final bool? isCompleted;

  PlannerModel({
    this.title,
    this.id,
    this.time,
    this.date,
    this.note,
    this.subject,
    this.type,
    this.isCompleted,
  });
}
