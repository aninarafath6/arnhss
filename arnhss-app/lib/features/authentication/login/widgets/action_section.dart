import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_button.dart';
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
        const CustomButton(
          label: "Get OTP",
        ),
        const Spacer(),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'By continuing, you agree to our Terms of ',
                style: CustomTextTheme(context: context).paragraph2(),
              ),
              TextSpan(
                text: 'Terms of Service ',
                style: TextStyle(
                  color: CustomColors.dark.withOpacity(1),
                  fontSize: context.getHeight(1.4),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'and',
                style: CustomTextTheme(context: context).paragraph2(),
              ),
              TextSpan(
                text: ' Privacy Policy',
                style: TextStyle(
                  fontSize: context.getHeight(1.4),
                  fontWeight: FontWeight.w500,
                  color: CustomColors.dark.withOpacity(1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
