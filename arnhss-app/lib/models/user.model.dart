import 'dart:convert';
import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.phone,
    this.id,
    // this.rollNumber,
    // this.dob,
    this.role,
    // this.localRole,
    // this.admissionNo,
    this.department,
    this.name,
    this.gender,
    this.dpURL,
    this.email,
    this.lastLogin,
  });

  final String? id;
  final String? phone;
  final String? email;
  // final int? rollNumber;
  // final String? dob;
  final Role? role;
  // final String? localRole;
  // final int? admissionNo;
  final Department? department;
  final String? name;
  final String? dpURL;
  final Gender? gender;
  final DateTime? lastLogin;

  factory UserModel.fromRawAdmin(String str, String id) =>
      UserModel.fromAdminJSON(json.decode(str), id);

  factory UserModel.fromRawStudent(String str, String id) =>
      UserModel.fromAdminJSON(json.decode(str), "");

  factory UserModel.fromRawJson(Map<String, dynamic> data, String? id) {
    // Map<String, dynamic> decoded = json.decode(str);
    id = data["id"] ?? id;

    Role? role = fromStringRole(data["role"]);

    if (role == Role.admin) {
      return UserModel.fromAdminJSON(data, id!);
    } else if (role == Role.student) {
      return UserModel.fromStudentJSON(data, id!);
    } else {
      return UserModel.fromParentJSON(data, id!);
    }
  }

  String toRawJson() => json.encode(toAdminJson().toString());

  // static List<UserModel> listFromJson(QuerySnapshot? data) {
  //   return data!.docs.map((e) {
  //     return UserModel.fromRawJson(jsonEncode(e.data()));
  //   }).toList();
  // }

  factory UserModel.fromAdminJSON(Map<String, dynamic> json, String id) {
    json["last_login"] = json["last_login"] as Timestamp;

    // print(fromStringRole(json["role"]));
    return UserModel(
      id: id,
      email: json["email"],
      phone: json["phone"],
      role: fromStringRole(json["role"]),
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: json["last_login"].toDate(),
    );
  }
  factory UserModel.fromStudentJSON(Map<String, dynamic> json, String id) =>
      UserModel(
        id: id,
        phone: json["phone"],
        email: json["email"],

        // // rollNumber: json["rollNumber"],
        // // dob: json["dob"],
        role: fromStringRole(json["role"]),
        // localRole: json["local-role"],
        // admissionNo: json["admission-no"],
        department: toDepartment(json["department"]),
        name: json["name"],
        dpURL: json["dpURL"],
        gender: toGender(json["gender"]),
        lastLogin: json["last_login"].toDate(),
      );

  factory UserModel.fromParentJSON(Map<String, dynamic> json, String id) {
    // print(fromStringRole(json["role"]));
    return UserModel(
      id: id,
      email: json["email"],
      phone: json["phone"],
      role: fromStringRole(json["role"]),
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: json["last_login"].toDate(),
    );
  }

  Map<String, dynamic> toStudentJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        // // "rollNumber": rollNumber,
        // // "dob": dob,
        "role": fromRole(role!),
        // "local-role": localRole,
        // "admission-no": admissionNo,
        "department": fromDepartment(department!),
        "dpURL": dpURL,
        "gender": fromGender(gender!),
        "lastLogin": Timestamp.fromDate(lastLogin ?? DateTime.now()),
      };

  Map<String, dynamic> toAdminJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "role": fromRole(role!),
        "dpURL": dpURL,
        "gender": fromGender(gender!),
        "lastLogin": Timestamp.fromDate(lastLogin ?? DateTime.now()),
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
        return Role.admin;
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
        return "admin";
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
