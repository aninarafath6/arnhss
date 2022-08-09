import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:flutter/material.dart';

class CountryViewModel with ChangeNotifier {
  final Future<List<CountryModel>> country = countryModelFromJson(getJson());
  Future<List<CountryModel>>? result = countryModelFromJson(getJson());

  final CountryModel _selectedCountry = CountryModel(
    name: "India",
    dialCode: "+91",
    code: "IN",
  );

  CountryModel get selectedCountry => _selectedCountry;
}
