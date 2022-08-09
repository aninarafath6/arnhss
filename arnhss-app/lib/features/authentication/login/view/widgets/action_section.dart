import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/widgets/custom_button.dart';
import 'package:arnhss/features/widgets/custom_button.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 0),
          width: context.getWidth(100),
          height: 55,
          decoration: BoxDecoration(
              color: const Color(0xfff1f5f9),
              borderRadius: BorderRadius.circular(8)),
          child: const CustomInput(),
        ),
        const SizedBox(height: 15),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'By continuing, you agree to our Terms of ',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              TextSpan(
                text: 'Terms of Service ',
                style: TextStyle(
                  color: CustomColors.dark.withOpacity(1),
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: 'and',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              TextSpan(
                text: ' Privacy Policy',
                style: TextStyle(
                  fontSize: 12,
                  color: CustomColors.dark.withOpacity(1),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        const CustomButton(label: "Get OTP"),
      ],
    );
  }
}
