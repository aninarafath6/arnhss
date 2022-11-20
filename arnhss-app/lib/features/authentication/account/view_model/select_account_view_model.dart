import 'dart:developer';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/features/authentication/repo/auth_service.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SelectAccountViewModel extends ChangeNotifier with HandleException {
  final AuthService _authService = AuthService();
  final SharedPrefService _sharedPrefService = SharedPrefService();
//* states
  int _selectedIndex = 0;
  final List<UserModel?> _profileList = [];
  bool _loading = false;
  bool _isEmpty = false;
  bool _buttonLoading = false;

  // * getters
  int get selectedIndex => _selectedIndex;
  List<dynamic> get profilesList => _profileList;
  bool get loading => _loading;
  bool get isEmpty => _isEmpty;
  bool get buttonLoading => _buttonLoading;

  //* setters
  set setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleButtonLoading() {
    _buttonLoading = !_buttonLoading;
    notifyListeners();
  }

  void toggleLoading() {
    _loading = !_loading;
  }

//* get profile of logged user
  Future<void> getProfiles(String phone, Role role) async {
    //? testing stuffs!!!
    // role = Role.student;
    // await _getSpecialUsers("+917444555666", role);
    await _getSpecialUsers(phone, role);

    return;
  }

//* get profile method
  Future<void> _getSpecialUsers(String phone, Role role) async {
    _isEmpty = false;
    //* setting loading as true
    toggleLoading();
    // * getting users list
    List<UserModel>? _specialUsers =
        await _authService.getUsersList(phone, role);
    //* clearing the old list
    _profileList.clear();
    //* adding new users list
    _profileList.addAll(_specialUsers ?? []);
    //* setting loading as false
    toggleLoading();
    //* checking profile is empty or not
    _isEmpty = _profileList.isEmpty;
    notifyListeners();
  }

  void signIn(
    AuthCredential? authCredential,
    UserModel user,
    Callback success,
  ) async {
    await _authService.signIn(authCredential, user).then((value) async {
      try {
        await _sharedPrefService.setUser(user);
        success();
      } catch (e) {
        log("error from sign in method");
        handleException(e);
      }
    });
  }
}
