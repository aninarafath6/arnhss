import 'dart:convert';

import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class Plan {
  final String? id;
  final String? title;
  final String? note;
  final TimeOfDay? remind;
  final DateTime? date;
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

  factory Plan.fromJson(String str) => Plan.fromMap(jsonDecode(str));
  // String toJson() => jsonEncode(toMap());

  factory Plan.fromMap(Map<String, dynamic> json) {
    return Plan(
      id: json["id"],
      title: json["title"],
      remind: json["remind"],
      date: json["date"],
      note: json["note"],
      type: json["type"],
      subject: json["subject"],
      isCompleted: json["isCompleted"],
    );
  }

  Map<String, String> toMap(BuildContext context) {
    return {
      "id": id.toString(),
      "title": title.toString(),
      "remind": remind!.format(context).toString(),
      "date": date.toString(),
      "note": note.toString(),
      "type": type.toString(),
      "subject": subject.toString(),
      "isComplete": isCompleted.toString(),
    };
  }
}
