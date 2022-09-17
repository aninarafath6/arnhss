class PlannerModel {
  final String? title;
  final String? subTitle;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? date;
  final String? note;
  final String? category;
  final String? type;
  final bool? isCompleted;

  PlannerModel({
    this.title,
    this.subTitle,
    this.startTime,
    this.endTime,
    this.date,
    this.note,
    this.category,
    this.type,
    this.isCompleted,
  });
}
