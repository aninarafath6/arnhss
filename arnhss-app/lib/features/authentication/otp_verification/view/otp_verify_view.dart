import 'dart:async';

import 'package:arnhss/common/theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import './index.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);
  static const routeName = "/verifyOtp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "",
        onBack: () => {
          context.read<VerifyOtpViewModel>().setOtp = null,
        },
      ),
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
            const _VerifyOtpActionButton(),
            context.spacing(height: 8),
          ],
        ),
      ),
    );
  }
}

class _VerifyOtpActionButton extends StatelessWidget {
  const _VerifyOtpActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: "Verify OTP",
      isDisabled: context.watch<VerifyOtpViewModel>().otp == null,
      onTap: () {
        if (context.read<VerifyOtpViewModel>().verifyOtp()) {
          showDialog(
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            "assets/lottie/lf30_editor_tsoh2riw.json",
                            fit: BoxFit.contain,
                            width: context.getWidth(60),
                            repeat: false,
                          ),
                        ),
                        Text(
                          "Welcome to ARNHSS",
                          style: CustomTextTheme(context: context)
                              .headLine()
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "Your mobile number Authentication is successful",
                          style: CustomTextTheme(context: context)
                              .paragraph()
                              .copyWith(color: Colors.grey[200]),
                        )
                      ],
                    ),
                    Lottie.asset("assets/lottie/85744-success.json",
                        repeat: false, fit: BoxFit.contain),
                  ],
                ),
              );
            },
          );
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/userRole", (r) => false);
            },
          );
        } else {
          customSnackBar(context, "sorry 😞, Please enter valid OTP");
        }
      },
    );
  }
}
