import 'package:arnhss/features/authentication/login/view/index.dart';

import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/shared_pref_service.dart';

class UserViewModel with ChangeNotifier {
  final SharedPrefService _prefService = SharedPrefService();
  UserModel? _user;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //* getters
  UserModel? get user => _user;

  // * get user
  void getUser() async {
    _user = await _prefService.getUser();
    notifyListeners();
  }
}
