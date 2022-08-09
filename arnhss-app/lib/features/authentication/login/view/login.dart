import 'package:arnhss/features/authentication/login/view/widgets/action_section.dart';
import 'package:arnhss/features/authentication/login/view/widgets/login_banner.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const ActionSection(),
              const Expanded(
                flex: 3,
                child: LoginBanner(),
              ),
              const Expanded(
                flex: 2,
                child: ActionSection(),
              ),

              context.spacing(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
