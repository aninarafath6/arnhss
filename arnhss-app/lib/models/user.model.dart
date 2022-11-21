import 'dart:convert';
import 'package:arnhss/common/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.phone,
      this.id,
      this.rollNumber,
      this.dob,
      this.role,
      this.admissionNo,
      this.department,
      this.name,
      required this.gender,
      this.dpURL,
      this.email,
      this.lastLogin,
      this.division,
      this.batch,
      this.secondLanguage,
      this.parentPhone,
      this.teacherSubject});

  final String? id;
  final String? phone;
  final String? email;
  final int? rollNumber;
  final DateTime? dob;
  final Role? role;
  // final String? localRole;
  final int? admissionNo;
  final Department? department;
  final String? name;
  final String? dpURL;
  final Gender gender;
  final DateTime? lastLogin;
  final String? division;
  final String? batch;
  final String? secondLanguage;
  final String? parentPhone;
  final String? teacherSubject;

//* json to userModel converter

  factory UserModel.fromRawJson(Map<String, dynamic> data, String? id) {
    // Map<String, dynamic> decoded = json.decode(str);
    id = data["id"] ?? id;

    Role? role = fromStringRole(data["role"]);

    if (role == Role.admin) {
      return UserModel.fromAdminJSON(data, id!);
    } else if (role == Role.student) {
      return UserModel.fromStudentJSON(data, id!);
    } else {
      return UserModel.fromTeacherJSON(data, id!);
    }
  }

  String toRawJson() {
    if (role == Role.admin) {
      return jsonEncode(toAdminJson());
    } else if (role == Role.student) {
      return jsonEncode(toStudentJson());
    } else {
      return jsonEncode(toTeacherJson());
    }
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

  factory UserModel.fromAdminJSON(Map<String, dynamic> json, String id) {
    print(json["role"]);
    print(fromStringRole(json["role"]));

    return UserModel(
      id: id,
      email: json["email"],
      phone: json["phone"],
      role: fromStringRole(json["role"]),
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: DateTime.fromMicrosecondsSinceEpoch(json["last_login"]),
    );
  }

  factory UserModel.fromTeacherJSON(Map<String, dynamic> json, String id) {
    return UserModel(
        id: id,
        email: json["email"],
        phone: json["phone"],
        role: fromStringRole(json["role"]),
        name: json["name"],
        dpURL: json["dpURL"],
        gender: toGender(json["gender"]),
        lastLogin: DateTime.fromMicrosecondsSinceEpoch(json["last_login"]),
        teacherSubject: json["subject"]);
  }
  factory UserModel.fromStudentJSON(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      phone: json["phone"],
      email: json["email"],
      rollNumber: json["roll_number"],
      dob: DateTime.fromMicrosecondsSinceEpoch(json["dob"]),
      role: fromStringRole(json["role"]),
      admissionNo: json["admission_number"],
      department: toDepartment(json["department"]),
      name: json["name"],
      dpURL: json["dpURL"],
      gender: toGender(json["gender"]),
      lastLogin: DateTime.fromMicrosecondsSinceEpoch(json["last_login"]),
      division: json["division"],
      batch: json["batch"],
      parentPhone: json["parent_phone"],
      secondLanguage: json["second_ language"],
    );
  }

  Map<String, dynamic> toStudentJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "roll_number": rollNumber,
        "dob": dob != null ? lastLogin?.microsecondsSinceEpoch : null,
        "role": toStringRole(role),
        "admission_number": admissionNo,
        "department": fromDepartment(department),
        "dpURL": dpURL,
        "gender": fromGender(gender),
        "division": division,
        "last_login": lastLogin?.microsecondsSinceEpoch,
        "batch": batch,
        "parent_phone": parentPhone,
        "second_ language": secondLanguage,
      };

  Map<String, dynamic> toAdminJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "role": toStringRole(role),
        "dpURL": dpURL,
        "gender": fromGender(gender),
        "last_login": lastLogin?.microsecondsSinceEpoch,
      };

  Map<String, dynamic> toTeacherJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "name": name,
        "role": toStringRole(role!),
        "dpURL": dpURL,
        "gender": fromGender(gender),
        "subject": teacherSubject,
        "last_login": lastLogin?.microsecondsSinceEpoch,
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

  static String fromDepartment(Department? department) {
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
}
