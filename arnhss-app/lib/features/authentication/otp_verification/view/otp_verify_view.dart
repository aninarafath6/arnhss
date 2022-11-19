import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/responsive_layout.dart';
import 'package:arnhss/features/onboarding/view/onboard_background.dart';
// import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';

import './index.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({Key? key}) : super(key: key);
  static const routeName = "/verifyOtp";

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  @override
  Widget build(BuildContext context) {
    debugPrint("=====OTP screen=====");

    return Scaffold(
      appBar: customAppBar(
        context,
        title: "",
        onBack: () => {
          context.read<VerifyOtpViewModel>().setOtp(null),
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ResponsiveLayout(
          mobile: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            controller: context.read<VerifyOtpViewModel>().otpScrollController,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: SizedBox(
                  height: context.getHeight(33),
                  child: Image.asset(
                    Images.otp_image,
                    width: context.getWidth(60),
                  ),
                ),
              ),
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
          tablet: Row(
            children: [
              const Expanded(
                  child: Background(image: Images.otp_image, padding: 30),
                  flex: 1),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView(
                controller:
                    context.read<VerifyOtpViewModel>().otpScrollController,
                shrinkWrap: true,
                children: [
                  const VerificationBanner(),
                  const SizedBox(height: 20),
                  const OtpInput(),
                  context.spacing(height: context.isMobile ? 10 : 5),
                  const ResendOtpSection(),
                  context.spacing(height: 2),
                  const _VerifyOtpActionButton(),
                ],
              )),
            ],
          ),
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
          Navigator.pushReplacementNamed(context, SelectAccount.routeName);

          // * dispose the old otp variable and other things
          context.read<VerifyOtpViewModel>().disp();
        }
      },
      width: context.isMobile ? context.getWidth(100) : context.getWidth(50),
      height: context.isMobile ? context.getHeight(8) : 60,
      fontSize: context.isMobile ? 15 : 15,
    );
  }
}
