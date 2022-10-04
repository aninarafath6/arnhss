import 'package:flutter/material.dart';

class NotificationModel {
  final String? id;
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final bool? isReade;

  NotificationModel({
    this.id,
    this.icon,
    this.title,
    this.subTitle,
    this.isReade,
  });
}
