import 'package:arnhss/features/authentication/otp_verification/widgets/select_rule_bottom_sheet.dart';

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
      loading: context.watch<VerifyOtpViewModel>().isLoading,
      onTap: () async {
        bool isOtpValid =
            await context.read<VerifyOtpViewModel>().verifyOtp(context);
        if (isOtpValid) {
          SelectRoleBottomShete(context);
        }
        // return context.read<VerifyOtpViewModel>().verifyOtp(context);
      },
    );
  }
}
