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
  final List<UserModel> _profileList = [];
  bool _loading = false;
  bool _isEmpty = false;
  bool _buttonLoading = false;

  // * getters
  int get selectedIndex => _selectedIndex;
  List<UserModel> get profilesList => _profileList;
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

//* get profile of logged user
  Future<void> getProfiles(String phone) async {
    _loading = true;
    var _profiles = await _authService.getListUsers(phone);
    _loading = false;
    _profileList.clear();
    _profileList.addAll(_profiles ?? []);
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
