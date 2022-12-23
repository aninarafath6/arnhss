import 'dart:convert';
import 'dart:developer';
import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  StudentModel({
    required this.phone,
    required this.id,
    required this.name,
    required this.gender,
    required this.dpURL,
    required this.email,
    required this.lastLogin,
    this.reference,
    required this.admissionNo,
    required this.dob,
    required this.parentPhone,
    required this.rollNumber,
    required this.secondLanguage,
    required this.department,
  });

  final String id;
  final String phone;
  final String email;
  final int rollNumber;
  final DateTime dob;
  final int admissionNo;
  final String name;
  final String dpURL;
  final Gender gender;
  final DateTime lastLogin;
  final String secondLanguage;
  final String parentPhone;
  final DocumentReference? reference;
  final String department;

  String toRawJson() {
    return jsonEncode(toTeacherJson());
  }

  factory StudentModel.fromJSON(Map<String, dynamic> json) {
    Timestamp lastLogin = json["last_login"];
    Timestamp dob = json["dob"];

    log(json.toString());
    return StudentModel(
      id: json["id"],
      department: json["department"],
      email: json["email"],
      phone: json["phone"],
      name: json["name"],
      dpURL: json["dpURL"],
      rollNumber: json["roll_no"],
      secondLanguage: json["second_lang"],
      gender: toGender(json["gender"]),
      reference: json["reference"],
      parentPhone: json["parent_phone"],
      admissionNo: json["admission_no"],
      dob: DateTime.fromMicrosecondsSinceEpoch(dob.microsecondsSinceEpoch),
      lastLogin:
          DateTime.fromMicrosecondsSinceEpoch(lastLogin.microsecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toTeacherJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "dpURL": dpURL,
        "roll_no": rollNumber,
        "second_lang": secondLanguage,
        "admission_no": admissionNo,
        "parent_phone": parentPhone,
        "gender": fromGender(gender),
        "dob": dob.microsecondsSinceEpoch,
        "last_login": lastLogin.microsecondsSinceEpoch,
      };

  //* helpers
  static Role? fromStringRole(String? role) {
    switch (role?.toLowerCase()) {
      case "student":
        return Role.student;
      case "parent":
        return Role.parent;
      case "teacher":
        return Role.teacher;
      case "principle":
        return Role.principle;
      default:
        return Role.admin;
    }
  }

  static String toStringRole(Role? role) {
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
        return "admin";
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
}
