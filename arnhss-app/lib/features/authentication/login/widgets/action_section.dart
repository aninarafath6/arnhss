import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_button.dart';
import 'package:arnhss/features/authentication/login/widgets/terms_paragraph.dart';
import 'package:arnhss/features/authentication/otp_verification/views/otp_verify_view.dart';
import 'package:arnhss/features/authentication/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.spacing(height: 5),
        Container(
          width: context.getWidth(100),
          height: 55,
          decoration: BoxDecoration(
              color: const Color(0xfff1f5f9),
              borderRadius: BorderRadius.circular(8)),
          child: const CustomInput(),
        ),
        const SizedBox(height: 25),
        CustomButton(
          label: "Get OTP",
          onTap: () {
            if (context.read<LoginViewModel>().otpDialog()) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(context
                            .read<CountryViewModel>()
                            .selectedCountry
                            .dialCode +
                        " " +
                        context
                            .read<LoginViewModel>()
                            .mobileNumberController
                            .text),
                    content: Text(
                      'would you like to continue with  this phone number to OTP verification?',
                      style: CustomTextTheme(context: context).paragraph(),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("EDIT")),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            OtpVerificationView.routeName,
                          );
                        },
                        child: const Text("CONTINUE"),
                      ),
                    ],
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                  );
                },
              );
            } else {
              const snackBar = SnackBar(
                backgroundColor: CustomColors.dark,
                content: Text('Invalid Phone number!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            // Navigator.pushNamed(context, OtpVerificationView.routeName);
          },
        ),
        const Spacer(),
        const TermsParagraph(),
      ],
    );
  }
}
