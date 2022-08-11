import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

Future<List<CountryModel>> countryModelFromJson(Future<String> str) async =>
    List<CountryModel>.from(
        json.decode(await str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  CountryModel({
    required this.name,
    required this.dialCode,
    required this.code,
  });

  final String name;
  final String dialCode;
  final String code;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        dialCode: json["dial_code"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dial_code": dialCode,
        "code": code,
      };
}

Future<String> getJson() async {
  return await rootBundle.loadString('assets/data/country.json');
}
