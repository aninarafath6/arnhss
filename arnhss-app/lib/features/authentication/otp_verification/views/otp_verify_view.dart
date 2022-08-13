import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/verification_banner.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/widgets/custom_app_bar.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/features/widgets/custom_snack_bar.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);
  static const routeName = "/verifyOtp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: ""),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const VerificationBanner(),
            context.spacing(height: 4),
            OtpTextField(
              focusedBorderColor: CustomColors.dark,
              keyboardType: TextInputType.number,
              numberOfFields: 5,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              // margin: const EdgeInsets.only(right: 15),
              autoFocus: false,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  },
                );
              }, // end onSubmit
            ),
            context.spacing(height: 10),
            Text(
              "Send OTP again after 00:${context.watch<VerifyOtpViewModel>().balanceTime} seconds",
              textAlign: TextAlign.center,
              style: CustomTextTheme(context: context).paragraph(),
            ),
            context.spacing(height: .8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.getWidth(25)),
              child: CustomButton(
                onTap: () => context.read<VerifyOtpViewModel>().balanceTime == 0
                    ? context
                        .read<LoginViewModel>()
                        .getOtp(context, reGet: true)
                    : customSnackBar(context,
                        "Please wait for ${context.read<VerifyOtpViewModel>().balanceTime} seconds"),
                label: "resend",
                textColor: context.watch<VerifyOtpViewModel>().resendAvailable
                    ? CustomColors.dark
                    : CustomColors.light,
                color: Colors.transparent,
                // width: 20,
                fontWeight: FontWeight.bold,
                height: 3,
              ),
            ),
            context.spacing(height: 2),
            CustomButton(
              label: "Verify OTP",
              onTap: () {
                int a = 10;
              },
            ),
            context.spacing(height: 8),
          ],
        ),
      ),
    );
  }
}
