import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/utils/dimensions.dart';
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
        SizedBox(
          height: context.getHeight(32),
          child: Image.asset("assets/images/pngs/login 1.png"),
        ),
        Text(
          "Login with Mobile Number",
          style: CustomTextTheme(context: context).headLine(),
        ),
        Text(
          'Enter your mobile number to Continue',
          style: CustomTextTheme(context: context).paragraph(),
        ),
      ],
    );
  }
}
