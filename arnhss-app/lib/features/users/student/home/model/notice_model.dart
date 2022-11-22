import 'dart:convert';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeModel {
  final String? id;
  final String? notice;
  final String? date;
  final Role? role;
  final IconData? icon;
  final DateTime? createdAt;
  final String? useId;

  NoticeModel({
    this.id,
    this.date,
    this.role,
    this.icon,
    this.createdAt,
    this.notice,
    this.useId,
  });

  factory NoticeModel.fromRawJson(String str) =>
      NoticeModel.fromJson(json.decode(str));

  static List<NoticeModel>? listFromJson(QuerySnapshot? data) {
    return data?.docs.map((e) {
          return NoticeModel.fromRawJson(jsonEncode(e.data()));
        }).toList() ??
        [];
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json["id"] ?? "",
      role: UserModel.fromStringRole(json["role"] ?? ""),
      date: json["date"] ?? "",
      useId: json["user_id"] ?? "",
      notice: json["notice"] ?? "",
      createdAt: DateTime.fromMicrosecondsSinceEpoch(json["created_at"]),
      // createdAt: json["created_at"] ?? DateTime.now(),
      // icon: jsonDecode(json["icon"]) ?? Remix.a24_hours_fill,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": UserModel.toStringRole(role),
      "notice": notice,
        "date": date,
        "user_id": useId,
        "icon": icon,
        "created_at": createdAt?.microsecondsSinceEpoch,
      };
}
