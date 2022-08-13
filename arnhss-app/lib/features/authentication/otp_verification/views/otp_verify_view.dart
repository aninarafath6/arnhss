import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/otp_input.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/verification_banner.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/widgets/custom_app_bar.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/features/widgets/custom_snack_bar.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: context.read<VerifyOtpViewModel>().otpScrollController,
          children: [
            const VerificationBanner(),
            context.spacing(height: 4),
            const OtpInput(),
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
              onTap: () {},
            ),
            context.spacing(height: 8),
          ],
        ),
      ),
    );
  }
}
