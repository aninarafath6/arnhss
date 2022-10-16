import 'package:arnhss/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setUser(UserModel user) async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", true);
    pref.setString("id", user.id?? "");
    // pref.setString("department", user.department!)
  }
}
