import 'package:arnhss/features/authentication/login/view/index.dart';

class UserRole extends StatelessWidget {
  const UserRole({Key? key}) : super(key: key);
  static const routeName = "/userRole";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text("user role selection page")));
  }
}
