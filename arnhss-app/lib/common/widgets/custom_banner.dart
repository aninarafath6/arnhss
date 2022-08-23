import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    Key? key,
    required this.image,
    required this.subtitle,
    required this.title,
  }) : super(key: key);
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: context.getHeight(32),
          child: Image.asset(image),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: CustomTextTheme(context: context).headLine(),
        ),
        const SizedBox(height: 15),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: CustomTextTheme(context: context).paragraph(),
        ),
      ],
    );
  }
}
