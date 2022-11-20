import 'dart:convert';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeModel {
  final String? id;
  final String? subject;
  final String? description;
  final String? subDescription;
  final String? date;
  final Role? role;
  final String? lastDate;
  final IconData? icon;

  NoticeModel({
    this.id,
    this.subject,
    this.description,
    this.subDescription,
    this.date,
    this.role,
    this.lastDate,
    this.icon,
  });

  factory NoticeModel.fromRawJson(String str) =>
      NoticeModel.fromJson(json.decode(str));

  static List<NoticeModel>? listFromJson(QuerySnapshot? data) {
    return data?.docs.map((e) {
          return NoticeModel.fromRawJson(jsonEncode(e.data()));
        }).toList() ??
        [];
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        id: json["id"] ?? "",
        subject: json["subject"] ?? "",
        description: json["description"] ?? "",
        subDescription: json["subDescription"] ?? "",
        role: fromStringRole(json["role"] ?? ""),
        date: json["date"] ?? "",
        // icon: jsonDecode(json["icon"]) ?? Remix.a24_hours_fill,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "subDescription": subDescription,
        "role": toStringRole(role ?? Role.student),
        "date": date,
        "icon": icon,
      };
}
