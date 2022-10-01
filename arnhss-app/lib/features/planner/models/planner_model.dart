import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class Plan {
  final String? id;
  final String? title;

  final TimeOfDay? remind;

  final DateTime? date;
  final String? note;
  final String? subject;
  final String? type;
  final bool? isCompleted;

  Plan({
    this.title,
    this.id,
    this.remind,
    this.date,
    this.note,
    this.subject,
    this.type,
    this.isCompleted,
  });

// factory
}
