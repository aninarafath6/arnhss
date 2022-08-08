import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/widgets/action_section.dart';
import 'package:arnhss/features/authentication/login/view/widgets/input_box.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(),
              Image.asset("assets/images/pngs/login 1.png"),
              Text(
                "Login with Mobile Number",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Enter your mobile number to Continue',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              context.spacing(height: 5),
              const ActionSection(),
              // const Spacer(flex: 10),
            ],
          ),
        ),
      ),
    );
  }
}
