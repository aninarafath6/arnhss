import 'package:arnhss/features/authentication/otp_verification/widgets/otp_input.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/resend_otp_section.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/verification_banner.dart';
import 'package:arnhss/features/authentication/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/widgets/custom_app_bar.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: context.read<VerifyOtpViewModel>().otpScrollController,
          children: [
            const VerificationBanner(),
            context.spacing(height: 4),
            const OtpInput(),
            context.spacing(height: 10),
            const ResendOtpSection(),
            context.spacing(height: 2),
            CustomButton(
              label: "Verify OTP",
              onTap: () => context.read<VerifyOtpViewModel>().verifyOtp,
            ),
            context.spacing(height: 8),
          ],
        ),
      ),
    );
  }
}
