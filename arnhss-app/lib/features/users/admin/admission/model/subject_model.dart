import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String name;
  final String code;
  final bool isSecondLang;
  final List<dynamic> teachers;
  final DocumentReference reference;
  final String id;

  SubjectModel({
    required this.name,
    required this.code,
    required this.isSecondLang,
    required this.teachers,
    required this.reference,
    required this.id,
  });

  Map<String, dynamic> toMap(SubjectModel subject) => {
        "name": name,
        "code": code,
        "second_lang": isSecondLang,
        "teachers": teachers,
      };

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id:map["id"],
        name: map["name"],
        code: map["code"],
        isSecondLang: map["second_lang"],
        teachers: map["teachers"] as List<dynamic>,
        reference: map["reference"]);
  }
}
