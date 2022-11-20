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
    // switch (role) {
    //   case Role.admin:
    //     _getSpecialUsers(phone, role);
    //     break;
    //   case Role.principle:
    //     _getSpecialUsers(phone, role);
    //     break;

    //   default:
    // }

    role = Role.admin;
    if (role == Role.admin || role == Role.principle) {
      await _getSpecialUsers("+917444555666", role);
      return;
    }
  }

  Future<void> _getSpecialUsers(String phone, Role role) async {
    toggleLoading();
    List<UserModel>? _specialUsers;
    _specialUsers = await _authService.getSpecialUsers(phone, role);
    _profileList.clear();
    _profileList.addAll(_specialUsers ?? []);
    toggleLoading();
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
        handleException(e);
      }
    });
  }
}
