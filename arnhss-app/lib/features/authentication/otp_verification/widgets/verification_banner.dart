import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationBanner extends StatelessWidget {
  const VerificationBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: context.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 50.0),
        //   child: SizedBox(
        //     height: context.getHeight(33),
        //     child: Image.asset(
        //       Images.otp_image,
        //       width: context.getWidth(60),
        //     ),
        //   ),
        // ),
        // // const SizedBox(height: 20),
        Text(
          "Check Your Message",
          textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
          style: CustomTextTheme(context: context).headLine(),
        ),
        context.spacing(height: 2),
        RichText(
          textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: "We've sent 6 digit code to ",
                style: CustomTextTheme(context: context).paragraph().copyWith(
                    fontSize: context.isMobile ? context.getHeight(1.7) : 15),
              ),
              TextSpan(
                text:
                    " ${context.read<CountryViewModel>().selectedCountry.dialCode + " " + context.read<LoginViewModel>().mobileNumberController.text} ",
                style: CustomTextTheme(context: context).paragraph().copyWith(
                      fontSize: context.isMobile ? context.getHeight(1.7) : 15,
                      color: CustomColors.dark,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              TextSpan(
                text: "for verify your mobile number ",
                style: CustomTextTheme(context: context).paragraph().copyWith(
                    fontSize: context.isMobile ? context.getHeight(1.7) : 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
