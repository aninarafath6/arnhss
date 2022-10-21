import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_footer.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
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
        const InputFelid(),
        const SizedBox(height: 25),
        CustomButton(
          label: "Get OTP",
          onTap: () {
            if (context.read<LoginViewModel>().validate()) {
              _customModal(context);
            }
            // if (context.read<LoginViewModel>().otpDialog()) {
            //   customModal(context);
            // } else {
            //   customSnackBar(
            //       content: "sorry 🙂, Please enter valid mobile number.");
            // }

            // Navigator.pushNamed(context, OtpVerificationView.routeName);
          },
        ),
        const Spacer(),
        const TermsParagraph(),
      ],
    );
  }

Future<dynamic> _customModal(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.read<CountryViewModel>().selectedCountry.dialCode +
            " " +
            context.read<LoginViewModel>().mobileNumberController.text),
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
              context.read<LoginViewModel>().getOtp(context);
            },
            child: context.watch<LoginViewModel>().loading
                ? const CupertinoActivityIndicator(
                    color: CustomColors.dark,
                  )
                : const Text("CONTINUE"),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}

}
