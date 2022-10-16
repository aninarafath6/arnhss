import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setUser(UserModel user) async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", true);
    pref.setString("id", user.id ?? "");
    pref.setString("department", UserModel.fromDepartment(user.department!));
    pref.setString("role", UserModel.fromRole(user.role ?? Role.student));
    pref.setString("name", user.name ?? "");
  }

  Future<String> start() async {
    SharedPreferences pref = await _prefs;
    bool? login = pref.getBool("login");

    if (login == null) {
      return OnboardingView.routeName;
    } else {
      return login ? HomeView.routeName : OnboardingView.routeName;
    }
  }
}
