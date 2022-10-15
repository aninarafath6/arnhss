import 'package:arnhss/features/authentication/repo/login_service.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:flutter/material.dart';

class SelectAccountViewModel extends ChangeNotifier {
  final LoginService _loginService = LoginService();

//* states
  int _selectedIndex = 0;
  final List<UserModel> _profileList = [];
  bool _loading = false;
  bool _isEmpty = false;

  // * getters
  int get selectedIndex => _selectedIndex;
  List<UserModel> get profilesList => _profileList;
  bool get loading => _loading;
  bool get isEmpty => _isEmpty;

  //* setters
  set setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

//* get profile of logged user
  Future<void> getProfiles() async {
    _loading = true;
    var _profiles = await _loginService.getListUsers();
    _loading = false;
    _profileList.clear();
    _profileList.addAll(_profiles!);
    _isEmpty = _profiles.isEmpty;
    notifyListeners();
  }
}
