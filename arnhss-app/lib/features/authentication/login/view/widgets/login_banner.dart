import 'package:flutter/material.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset("assets/images/pngs/login 1.png"),
        Text(
          "Login with Mobile Number",
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          'Enter your mobile number to Continue',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
