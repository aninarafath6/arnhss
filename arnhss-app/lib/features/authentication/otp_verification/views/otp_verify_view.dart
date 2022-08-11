import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:arnhss/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);
  static const routeName = "/verifyOtp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Verification"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/pngs/ab96085c6e789dcd46f381d8ddce48ce.png.webp",
                  ),
                  Text(
                    "Check Your Message",
                    style: CustomTextTheme(context: context).headLine(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We've sent 6 digit code to ${context.read<CountryViewModel>().selectedCountry.dialCode} 9947018118 for verify your mobile number",
                    textAlign: TextAlign.center,
                    style: CustomTextTheme(context: context).paragraph(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
