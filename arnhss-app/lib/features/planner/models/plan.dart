import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/utils/bool_parse.dart';

class Plan {
  Plan({
    this.id,
    this.title,
    this.note,
    this.date,
    this.type,
    this.remind,
    this.subject,
    this.isComplete,
  });

  final String? id;
  final String? title;
  final String? note;
  final DateTime? date;
  final String? type;
  final TimeOfDay? remind;
  final String? subject;
  final bool? isComplete;

  factory Plan.fromRawJson(Map<String, dynamic> map) => Plan.fromJson((map));

  Map<String, dynamic> toRawMap(context) => toJson((context));

  factory Plan.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json["date"]);
    var time = json["remind"].toString().split(":");

    return Plan(
      id: json["id"],
      title: json["title"],
      note: json["note"],
      date: date,
      type: json["type"],
      remind: TimeOfDay(
          hour: int.parse(time[0]), minute: int.parse(time[1].split(" ")[0])),
      subject: json["subject"],
      isComplete: json["isComplete"].toString().parseBool(),
    );
  }

  Map<String, dynamic> toJson(context) => {
        "id": id,
        "title": title,
        "note": note,
        "date": DateTime.utc(date!.year, date!.month, date!.day).toString(),
        "type": type,
        "remind": remind?.format(context),
        "subject": subject,
        "isComplete": isComplete.toString()
      };
}
