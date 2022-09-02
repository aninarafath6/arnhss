import 'package:flutter/material.dart';

class NoticeModel {
  final String? title;
  final String? description;
  final String? subDescription;
  final String? date;
  final String? role;
  final String? lastDate;
  final IconData? icon;

  NoticeModel({
    this.title,
    this.description,
    this.subDescription,
    this.date,
    this.role,
    this.lastDate,
    this.icon,
  });
}
