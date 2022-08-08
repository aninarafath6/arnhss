import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset("assets/images/pngs/login 1.png"),
          const Text("Login with Mobile Number"),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
