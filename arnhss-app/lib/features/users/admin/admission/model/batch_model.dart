// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Batch {
  final String id;
  late final String code;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  Batch({
    required this.name,
    required this.code,
    required this.id,
    required this.endDate,
    required this.startDate,
  });

  Map<String, dynamic> toMap() => {
        "code": code.toUpperCase(),
        "name": name,
        "start_date": Timestamp.fromDate(startDate),
        "end_date": Timestamp.fromDate(endDate),
      };

  factory Batch.fromMap(Map<String, dynamic> batchMap) {
    Timestamp _startDate = batchMap["start_date"] as Timestamp;
    Timestamp _endDate = batchMap["end_date"] as Timestamp;

    return Batch(
      id: batchMap["id"],
      name: batchMap["name"].toString().toUpperCase(),
      code: batchMap["code"].toString(),
      startDate: _startDate.toDate(),
      endDate: _endDate.toDate(),
    );
  }
}
