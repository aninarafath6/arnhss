import 'dart:convert';

import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  AdminModel({
    this.phone,
    this.id,
    this.dob,
    this.role,
    this.localRole,
    this.admissionNo,
    this.department,
    this.name,
    this.gender,
    this.dpURL,
  });

  final String? id;
  final String? phone;
  final String? dob;
  final Role? role;
  final String? localRole;
  final int? admissionNo;
  final Department? department;
  final String? name;
  final String? dpURL;
  final Gender? gender;

  factory AdminModel.fromRawJson(String str) =>
      AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static List<AdminModel> listFromJson(QuerySnapshot? data) {
    return data!.docs.map((e) {
      return AdminModel.fromRawJson(jsonEncode(e.data()));
    }).toList();
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json["id"],
        phone: json["phone"],
        dob: json["dob"],
        role: fromStringRole(json["role"]),
        localRole: json["local-role"],
        admissionNo: json["admission-no"],
        department: toDepartment(json["department"]),
        name: json["name"],
        dpURL: json["profileImageURL"],
        gender: toGender(json["gender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "dob": dob,
        "role": fromRole(role!),
        "local-role": localRole,
        "admission-no": admissionNo,
        "department": fromDepartment(department!),
        "name": name,
        "profileImageURL": dpURL,
        "gender": fromGender(gender!),
      };

  static Role? fromStringRole(String role) {
    switch (role.toLowerCase()) {
      case "student":
        return Role.student;
      case "parent":
        return Role.parent;
      case "teacher":
        return Role.teacher;
      case "principle":
        return Role.principle;
      default:
        return Role.student;
    }
  }

  static String toStringRole(Role role) {
    switch (role) {
      case Role.student:
        return "Student";
      case Role.parent:
        return "Parent";
      case Role.teacher:
        return "Teacher";
      case Role.principle:
        return "Principle";
      default:
        return "Student";
    }
  }

  static String fromRole(Role role) {
    switch (role) {
      case Role.student:
        return "Student";
      case Role.teacher:
        return "Teacher";
      case Role.parent:
        return "Parent";
      case Role.principle:
        return "Principle";

      default:
        return "Student";
    }
  }

  static Gender toGender(String str) {
    switch (str.toLowerCase()) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.other;
    }
  }

  static String fromGender(Gender gender) {
    switch (gender) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      default:
        return "Other";
    }
  }

  static Department toDepartment(String str) {
    switch (str.toLowerCase()) {
      case "commerce":
        return Department.commerce;
      case "computer science":
        return Department.cs;
      case "science":
        return Department.science;
      default:
        return Department.humanities;
    }
  }

  static String fromDepartment(Department department) {
    switch (department) {
      case Department.commerce:
        return "Commerce";
      case Department.cs:
        return "Computer science";
      case Department.science:
        return "Science";
      default:
        return "Humanities";
    }
  }
}
