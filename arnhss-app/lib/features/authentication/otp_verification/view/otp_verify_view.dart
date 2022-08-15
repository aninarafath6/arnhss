import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';

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
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(AppSizes.defualt_padding + 2),
              height: context.getHeight(40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    "Select Your Role",
                    style: CustomTextTheme(context: context)
                        .headLine()
                        .copyWith(fontSize: 20),
                  ),
                  context.spacing(height: 5),
                  Container(
                    height: context.getHeight(7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        AppSizes.defualt_border_raidus,
                      ),
                    ),
                    child: const ListTile(
                      title: Text("student"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        // return context.read<VerifyOtpViewModel>().verifyOtp(context);
      },
    );
  }
}
