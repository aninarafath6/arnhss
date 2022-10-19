import 'dart:convert';

import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class NoticeModel {
  final String? id;
  final String? title;
  final String? description;
  final String? subDescription;
  final String? date;
  final Role? role;
  final String? lastDate;
  final IconData? icon;

  NoticeModel({
    this.id,
    this.title,
    this.description,
    this.subDescription,
    this.date,
    this.role,
    this.lastDate,
    this.icon,
  });

  factory NoticeModel.fromRawJson(String str) =>
      NoticeModel.fromJson(json.decode(str));

  static List<NoticeModel> listFromJson(QuerySnapshot? data) {
    return data?.docs.map((e) {
          return NoticeModel.fromRawJson(jsonEncode(e.data()));
        }).toList() ??
        [];
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        subDescription: json["subDescription"] ?? "",
        role: fromStringRole(json["role"] ?? ""),
        date: json["date"] ?? "",
        // icon: jsonDecode(json["icon"]) ?? Remix.a24_hours_fill,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "subDescription": subDescription,
        "role": toRoleString(role),
        "date": date,
        "icon": icon,
      };

  static Role? fromStringRole(String role) {
    switch (role) {
      case "student":
        return Role.student;
      case "parent":
        return Role.parent;
      case "teacher":
        return Role.teacher;
      default:
        return Role.student;
    }
  }

  static String toRoleString(Role? role) {
    switch (role) {
      case Role.student:
        return "student";
      case Role.parent:
        return "parent";
      case Role.teacher:
        return "teacher";
      default:
        return "student";
    }
  }
}
