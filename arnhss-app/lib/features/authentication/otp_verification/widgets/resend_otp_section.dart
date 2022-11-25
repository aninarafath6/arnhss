import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResendOtpSection extends StatelessWidget {
  const ResendOtpSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isResentAvl = context.read<VerifyOtpViewModel>().balanceTime == 0;
    return Column(
      children: [
        Text(
          "Send OTP again after 00:${context.watch<VerifyOtpViewModel>().balanceTime} seconds",
          textAlign: TextAlign.center,
          style: CustomTextTheme(context: context).paragraph().copyWith(
                fontSize: context.isMobile ? context.getHeight(1.7) : 15,
              ),
        ),
        context.spacing(height: context.isMobile ? 1 : 0),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getWidth(0),
          ),
          child: CustomButton(
            elevation: false,
            
            onTap: () => isResentAvl
                ? context.read<LoginViewModel>().getOtp(
                      context,
                      reGet: true,
                    )
                : customSnackBar(
                    content:
                        "⏳ Please wait for ${context.read<VerifyOtpViewModel>().balanceTime} seconds ",
                  ),
            label: "resend",
            fontSize: context.isMobile ? context.getHeight(1.7) : 15,
            textColor: context.watch<VerifyOtpViewModel>().resendAvailable
                ? CustomColors.dark
                : CustomColors.light,
            color: Colors.transparent,
            width: 100,
            fontWeight: FontWeight.bold,
            height: 50,
          ),
        ),
      ],
    );
  }
}
