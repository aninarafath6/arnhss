import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationBanner extends StatelessWidget {
  const VerificationBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        Images.otp_image,
      ),
      Text(
        "Check Your Message",
        style: CustomTextTheme(context: context).headLine(),
        textAlign: TextAlign.center,
      ),
      context.spacing(height: 2),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "We've sent 6 digit code to ",
              style: CustomTextTheme(context: context).paragraph(),
            ),
            TextSpan(
              text:
                  " ${context.read<CountryViewModel>().selectedCountry.dialCode + " " + context.read<LoginViewModel>().mobileNumberController.text} ",
              style: CustomTextTheme(context: context).paragraph().copyWith(
                    color: CustomColors.dark,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            TextSpan(
                text: "for verify your mobile number ",
                style: CustomTextTheme(context: context).paragraph()),
          ],
        ),
      ),
    ]);
  }
}
