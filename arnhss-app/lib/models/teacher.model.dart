import 'dart:convert';
import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  TeacherModel({
    required this.phone,
    required this.id,
    required this.role,
    required this.name,
    required this.gender,
    required this.dpURL,
    required this.email,
    required this.lastLogin,
    this.reference,
  });

  final String id;
  final String phone;
  final String email;
  final DocumentReference? reference;

  final Role role;

  // final String? localRole;
  final String name;
  final String dpURL;
  final Gender gender;
  final DateTime lastLogin;

  // bool operator ==(dynamic other) =>
  //     other != null && other is TimeSelection && this.hour == other.hour;

  factory TeacherModel.fromRawJson(Map<String, dynamic> data, String? id) {
    return TeacherModel.fromTeacherJSON(data);
  }

  String toRawJson() {
    return jsonEncode(toTeacherJson());
  }

  // static List<UserModel> listFromJson(QuerySnapshot? data) {
  //   return data!.docs.map((e) {
  //     return UserModel.fromRawJson(jsonEncode(e.data()));
  //   }).toList();
  // }

  // factory UserModel.fromRawAdmin(String str, String id) =>
  //     UserModel.fromAdminJSON(json.decode(str), id);

  // factory UserModel.fromRawStudent(String str, String id) =>
  //     UserModel.fromAdminJSON(json.decode(str), "");

  factory TeacherModel.fromTeacherJSON(Map<String, dynamic> json) {
    print(json);
    Timestamp lastLogin = json["last_login"];
    return TeacherModel(
      id: json["id"],
      email: json["email"],
      phone: json["phone"],
      role: fromStringRole(json["role"]) ?? Role.teacher,
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      reference: json["reference"],
      lastLogin:
          DateTime.fromMicrosecondsSinceEpoch(lastLogin.microsecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toTeacherJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "role": toStringRole(role),
        "dpURL": dpURL,
        "gender": fromGender(gender),
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

  // static String toStringRole(Role? role) {
  //   switch (role) {
  //     case Role.student:
  //       return "student";
  //     case Role.teacher:
  //       return "teacher";
  //     case Role.parent:
  //       return "parent";
  //     case Role.principle:
  //       return "principle";
  //     case Role.admin:
  //       return "admin";
  //     default:
  //       return "Student";
  //   }
  // }

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
