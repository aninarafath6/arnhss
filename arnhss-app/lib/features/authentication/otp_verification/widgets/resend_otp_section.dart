import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/features/widgets/custom_snack_bar.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResendOtpSection extends StatelessWidget {
  const ResendOtpSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Send OTP again after 00:${context.watch<VerifyOtpViewModel>().balanceTime} seconds",
          textAlign: TextAlign.center,
          style: CustomTextTheme(context: context).paragraph(),
        ),
        context.spacing(height: .8),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getWidth(25),
          ),
          child: CustomButton(
            onTap: () => context.read<VerifyOtpViewModel>().balanceTime == 0
                ? context.read<LoginViewModel>().getOtp(
                      context,
                      reGet: true,
                    )
                : customSnackBar(
                    context,
                    "⏳ Please wait for ${context.read<VerifyOtpViewModel>().balanceTime} seconds ",
                  ),
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
      ],
    );
  }
}
