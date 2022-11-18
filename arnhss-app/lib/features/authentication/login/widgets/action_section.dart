import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_drop_down.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_footer.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({
    Key? key,
    this.subtitle,
    required this.title,
    this.isSmall = false,
  }) : super(key: key);
  final String? title;
  final String? subtitle;

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: context.watch<LoginViewModel>().scrollController,

      // crossAxisAlignment: context.isMobile
      //     ? CrossAxisAlignment.center
      //     : CrossAxisAlignment.start,
      shrinkWrap: true,
      // primary: true,
      children: [
        Text(
          title ?? "",
          key: ValueKey(title.toString()),
          textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
          style: CustomTextTheme(context: context).headLine(),
        ),
        Text(
          subtitle ?? "",
          textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
          style: CustomTextTheme(context: context).paragraph().copyWith(
              fontSize: context.isMobile ? context.getHeight(1.7) : 15),
        ),
        context.spacing(height: 5),
        const InputFelid(),
        const SizedBox(height: 10),
        const CustomDropDown(
          title: "Choose your role",
          leadingIcon: Remix.arrow_down_s_line,
          options: ["Student", "Teacher", "Principal", "Admin"],
        ),
        SizedBox(height: context.isMobile ? 25 : 15),
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
          width:
              context.isMobile ? context.getWidth(100) : context.getWidth(50),
          height: context.isMobile ? context.getHeight(8) : 60,
          fontSize: context.isMobile ? 15 : 15,
        ),
        // CustomButton(
        //   label: "Get OTP",
        //   onTap: () {
        //     if (context.read<LoginViewModel>().validate()) {
        //       _customModal(context);
        //     }
        //     // if (context.read<LoginViewModel>().otpDialog()) {
        //     //   customModal(context);
        //     // } else {
        //     //   customSnackBar(
        //     //       content: "sorry 🙂, Please enter valid mobile number.");
        //     // }

        //     // Navigator.pushNamed(context, OtpVerificationView.routeName);
        //   },
        // ),
        // context.isMobile ? context.spacing(height: 3) : const SizedBox(),
        // context.isMobile ? const TermsParagraph() : const SizedBox(),
      ],
    );
  }

  Future<dynamic> _customModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              context.read<CountryViewModel>().selectedCountry.dialCode +
                  " " +
                  context.read<LoginViewModel>().mobileNumberController.text),
          content: Text(
            'would you like to continue with  this phone number to OTP verification?',
            style: CustomTextTheme(context: context)
                .paragraph()
                .copyWith(fontSize: 15),
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
