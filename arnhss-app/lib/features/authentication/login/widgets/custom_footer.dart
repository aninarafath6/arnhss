import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class TermsParagraph extends StatelessWidget {
  const TermsParagraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}
