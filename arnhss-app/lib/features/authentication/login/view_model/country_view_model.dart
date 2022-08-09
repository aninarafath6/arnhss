import 'package:arnhss/features/authentication/login/models/country_dropdown_model.dart';
import 'package:flutter/material.dart';

class CountryViewModel with ChangeNotifier {
  final Future<List<CountryModel>> _allCountry =
      countryModelFromJson(getJson());
  Future<List<CountryModel>>? _result = countryModelFromJson(getJson());

  // used to keybord overlap
  bool _isDropDownOpen = false;

  CountryModel _selectedCountry = CountryModel(
    name: "India",
    dialCode: "+91",
    code: "IN",
  );

  CountryModel get selectedCountry => _selectedCountry;
  Future<List<CountryModel>>? get result => _result;
  Future<List<CountryModel>> get country => _allCountry;
  bool get isDropDownOpen => _isDropDownOpen;

  void updateDropDown(bool status) {
    _isDropDownOpen = status;
  }

  void setCountry(CountryModel country) {
    _selectedCountry = country;
    notifyListeners();
    _result = _allCountry;
    updateDropDown(false);
  }

  void searchCountry(String qry) {
    qry = qry.toLowerCase();
    if (qry.isEmpty) {
      _result = _allCountry;
    } else {
      _result = _allCountry.then(
        (country) => country.where((element) {
          return element.code.toLowerCase().contains(qry) ||
              element.name.toLowerCase().contains(qry) ||
              element.dialCode.toLowerCase().contains(qry);
        }).toList(),
      );
    }
    notifyListeners();
  }
}
