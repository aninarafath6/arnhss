import 'dart:convert';

import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.specialUser,
      this.student,
      this.teacher,
      required this.id,
      required this.role,
      this.data});

  final Student? student;
  final Teacher? teacher;
  final SpecialUser? specialUser;
  final Role role;
  final String id;
  final Map<String, dynamic>? data;

  factory UserModel.fromJson(Map<String, dynamic> json, String? id) {
    id = json["id"] ?? id;
    Role? role = fromStringRole(json["role"]);

    if (role == Role.admin || role == Role.student) {
      return UserModel(
        id: id!,
        role: role ?? Role.admin,
        specialUser: SpecialUser.fromJson(json),
        data: json,
      );
    } else if (role == Role.student) {
      return UserModel(
        id: id!,
        role: role ?? Role.student,
        student: Student.fromJson(json),
      );
    } else {
      return UserModel(
        id: id!,
        role: role ?? Role.parent,
      );
    }
  }

  String toJson() {
    if (role == Role.admin || role == Role.principle) {
      return jsonEncode(
        {
          "id": id,
          "role": role,
          ...SpecialUser().toJson(),
        },
      );
    } else if (role == Role.student) {
      return jsonEncode(
        {
          "id": id,
          "role": role,
          ...Student().toStudentJson(),
        },
      );
    } else {
      return jsonEncode(
        {
          "id": id,
          "role": role,
        },
      );
    }
  }
}

class Student {
  final String? id;
  final String? phone;
  final String? email;
  final int? rollNumber;
  final DateTime? dob;
  final int? admissionNo;
  final Department? department;
  final String? name;
  final String? dpURL;
  final Gender? gender;
  final DateTime? lastLogin;
  final String? division;
  final String? batch;
  final String? secondLanguage;
  final String? parentPhone;

  Student({
    this.id,
    this.phone,
    this.email,
    this.rollNumber,
    this.dob,
    this.admissionNo,
    this.department,
    this.name,
    this.dpURL,
    this.gender,
    this.lastLogin,
    this.division,
    this.batch,
    this.secondLanguage,
    this.parentPhone,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      phone: json["phone"],
      email: json["email"],
      rollNumber: json["roll_number"],
      dob: json["dob"].toDate(),
      admissionNo: json["admission_number"],
      department: toDepartment(json["department"]),
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: json["last_login"].toDate(),
      division: json["division"],
      batch: json["batch"],
      parentPhone: json["parent_phone"],
      secondLanguage: json["second_ language"],
    );
  }

//* to json convertor
  Map<String, dynamic> toStudentJson() => {
        "id": id ?? "",
        "phone": phone ?? "",
        "email": email ?? "",
        "name": name ?? "",
        "roll_number": rollNumber ?? "",
        "dob": Timestamp.fromDate(dob!),
        "admission_number": admissionNo ?? "",
        "department": fromDepartment(department!),
        "dpURL": dpURL ?? "",
        "gender": fromGender(gender!),
        "division": division,
        "lastLogin": Timestamp.fromDate(lastLogin ?? DateTime.now()),
        "batch": batch ?? "",
        "parent_phone": parentPhone ?? "",
        "second_ language": secondLanguage ?? "",
      };
}

class SpecialUser {
  SpecialUser({
    this.id,
    this.email,
    this.phone,
    this.name,
    this.dpURL,
    this.gender,
    this.lastLogin,
  });

  final String? id;
  final String? email;
  final String? phone;
  final String? name;
  final String? dpURL;
  final Gender? gender;
  final DateTime? lastLogin;

  factory SpecialUser.fromJson(Map<String, dynamic> json) {
    json["last_login"] = json["last_login"] as Timestamp;

    return SpecialUser(
      email: json["email"],
      phone: json["phone"],
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: json["last_login"].toDate(),
    );
  }
  // final
  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "dpURL": dpURL,
        "gender": fromGender(gender!),
        "lastLogin": Timestamp.fromDate(lastLogin ?? DateTime.now()),
      };
}

class Teacher {}

Role? fromStringRole(String role) {
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

String toStringRole(Role role) {
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

String fromRole(Role role) {
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

Gender toGender(String str) {
  switch (str.toLowerCase()) {
    case "male":
      return Gender.male;
    case "female":
      return Gender.female;
    default:
      return Gender.other;
  }
}

String fromGender(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "Male";
    case Gender.female:
      return "Female";
    default:
      return "Other";
  }
}

Department toDepartment(String str) {
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

String fromDepartment(Department department) {
  switch (department) {
    case Department.commerce:
      return "Commerce";
    case Department.cs:
      return "Computer Science";
    case Department.science:
      return "Science";
    default:
      return "Humanities";
  }
}
