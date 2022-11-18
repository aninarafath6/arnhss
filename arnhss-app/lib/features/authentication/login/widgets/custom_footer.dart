import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TermsParagraph extends StatelessWidget {
  const TermsParagraph({
    Key? key,
    this.size = 12,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'By continuing, you agree to our Terms of ',
              style: CustomTextTheme(context: context)
                  .paragraph2()
                  .copyWith(fontSize: size),
            ),
            TextSpan(
              text: 'Terms of Service ',
              style: CustomTextTheme(context: context).paragraph2().copyWith(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'and',
              style: CustomTextTheme(context: context)
                  .paragraph2()
                  .copyWith(fontSize: size),
            ),
            TextSpan(
              text: ' Privacy Policy',
              style: CustomTextTheme(context: context).paragraph2().copyWith(
                  fontSize: size,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
