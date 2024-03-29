import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_drop_down.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';

import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
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
      shrinkWrap: true,
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
        Consumer<LoginViewModel>(builder: (context, provider, child) {
          return EnumDropDown<Role>(
            title: "Choose your role",
            leadingIcon: Remix.arrow_down_s_line,
            options: const [
              Role.student,
              Role.teacher,
              Role.principle,
              Role.admin
            ],
            value: provider.getUserRole,
            changed: (role) {
              provider.setUserRole = role;
            },
          );
        }),
        SizedBox(height: context.isMobile ? 25 : 15),
        CustomButton(
          label: "Get OTP",
          onTap: () {
            // var loading = context.watch<LoginViewModel>().loading;
            if (context.read<LoginViewModel>().validate()) {
              // var title = context
              //         .read<CountryViewModel>()
              //         .selectedCountry
              //         .dialCode +
              //     " " +
              //     context.read<LoginViewModel>().mobileNumberController.text;
              // customModal(context,
              //     content:
              //         'would you like to continue with  this phone number to OTP verification?',
              //     title: title,
              //     deny: "EDIT",
              //     onDeny: () {
              //       Navigator.pop(context);
              //     },
              //     onDone: () =>
              //         context.read<LoginViewModel>().getOtp(context, req: true),
              //     // loading: loading,
              //     loadingWidget: const CupertinoActivityIndicator(
              //       color: CustomColors.dark,
              //     ));
              loginModal(
                context,
                content:
                    'would you like to continue with  this phone number to OTP verification?',
                title: context
                        .read<CountryViewModel>()
                        .selectedCountry
                        .dialCode +
                    " " +
                    context.read<LoginViewModel>().mobileNumberController.text,
                onDeny: () {
                  Navigator.pop(context);
                },
                done: const Text("CONTINUE"),
                onDone: () {
                  context.read<LoginViewModel>().getOtp(context, req: true);
                },
              );
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
      ],
    );
  }
}
