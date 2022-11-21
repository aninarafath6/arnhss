import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/users/role_wrapper.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService with HandleException {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

// * set user
  Future<void> setUser(UserModel user) async {
    try {
      // * call sharedPreference
      SharedPreferences pref = await _prefs;
      pref.setBool("login", true);
      pref.setString("id", user.id ?? "");
      if (user.role == Role.student) {
        pref.setString(
            "department", UserModel.fromDepartment(user.department!));
      }
      pref.setString("role", UserModel.toStringRole(user.role));
      pref.setString("name", user.name ?? "");
      pref.setString("user", user.toRawJson());
    } catch (e) {
      log("error from set user on localStorage $e");
      handleException(e);
    }
  }

// * get starting route name with help  of log state
  Future<String> start() async {
    SharedPreferences pref = await _prefs;
    bool? login = pref.getBool("login");
    String? role = pref.getString("role");
    if (role == null) {
      return LoginView.routeName;
    } else {
      if (login == null) {
        return OnboardingView.routeName;
      } else {
        return login ? RoleWrapper.routeName : OnboardingView.routeName;
      }
    }
  }

  Future<UserModel?> getUser() async {
    try {
      SharedPreferences pref = await _prefs;

      String rawUser = pref.getString("user").toString();

      if (rawUser != "") {
        Map<String, dynamic> userObject =
            jsonDecode(rawUser) as Map<String, dynamic>;
        print(userObject);

        UserModel user = UserModel.fromRawJson(userObject, null);

        return user;
      } else {
        throw InvalidException(
            "Local User not found🤔\nPlease login again ", false);
      }
    } catch (e) {
      log("exception from getUser method in sharedPref $e", zone: Zone.current);
      handleException(e);
    }
    return null;
  }

//* get user role from local storage
  Future<Role?> getRole() async {
    print("call is here");
    try {
      SharedPreferences pref = await _prefs;
      String? stringRole = pref.getString("role");
      return UserModel.fromStringRole(stringRole);
    } catch (e) {
      debugPrint("error from getRole in sharedPref +$e");
      handleException(e);
      return null;
    }
  }

// * clear all log state
  Future<void> clear() async {
    try {
      SharedPreferences pref = await _prefs;
      pref.setBool("login", false);
      pref.remove("id");
      pref.remove("department");
      pref.remove("role");
      pref.remove("name");
    } catch (e) {
      handleException(e);
    }
  }
}
