import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  static const String routeName = "/wrapper";

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    debugPrint("Hay,${user?.displayName}");
    if (user == null) {
      debugPrint("user is not logged in ");
      return const OnboardingView();
    } else {
      debugPrint("user is already logged in ");
      setState(() {});
      return const HomeView();
    }
  }
}
