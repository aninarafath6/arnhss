import 'dart:convert';
import 'dart:developer';

import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
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
      pref.setString("id", user.id);
      if (user.role == Role.student) {
        pref.setString("department", fromDepartment(user.student!.department!));
      }
      pref.setString("role", toStringRole(user.role));
      pref.setString("user", user.toJson());
    } catch (e) {
      log("error from set user on localStorage $e");
      handleException(e);
    }
  }

// * get starting route name with help  of log state
  Future<String> start() async {
    SharedPreferences pref = await _prefs;
    bool? login = pref.getBool("login");
    if (login == null) {
      return OnboardingView.routeName;
    } else {
      return login ? HomeView.routeName : OnboardingView.routeName;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      SharedPreferences pref = await _prefs;
      Map<String, dynamic>? rawUser =
          jsonDecode(jsonEncode(pref.getString("user")));
      if (rawUser != null) {
        return UserModel.fromJson(rawUser, null);
      } else {
        throw InvalidException("User not found🤔", false);
      }
    } catch (e) {
      log("error from  get user method in sharedPref $e");
      handleException(e);
    }
    return null;
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
