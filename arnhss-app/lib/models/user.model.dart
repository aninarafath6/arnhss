// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:arnhss/features/authentication/account/view/select_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.phone,
    this.rollNumber,
    this.dob,
    this.role,
    this.localRole,
    this.admissionNo,
    this.department,
    this.name,
  });

  final String? phone;
  final int? rollNumber;
  final String? dob;
  final Role? role;
  final String? localRole;
  final int? admissionNo;
  final String? department;
  final String? name;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static List<UserModel> listFromJson(QuerySnapshot? data) {
    return data!.docs.map((e) {
      return UserModel.fromRawJson(jsonEncode(e.data()));
    }).toList();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: json["phone"],
        rollNumber: json["rollNumber"],
        dob: json["dob"],
        role: fromStringRole(json["role"]),
        localRole: json["local-role"],
        admissionNo: json["admission-no"],
        department: json["department"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "rollNumber": rollNumber,
        "dob": dob,
        "role": toRole(role!),
        "local-role": localRole,
        "admission-no": admissionNo,
        "department": department,
        "name": name,
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

  static String toRole(Role role) {
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
