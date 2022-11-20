import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    Key? key,
    required this.image,
    this.subtitle,
    required this.title,
    this.titiling = false,
    this.isSmall = false,
  }) : super(key: key);
  final String image;
  final String title;
  final String? subtitle;
  final bool isSmall;
  final bool titiling;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: context.getHeight(isSmall ? 20 : 32),
            key: ValueKey(image.toString()),
            child: Image.asset(
              image,
            ),
          ),
          titiling
              ? Text(
                  title,
                  key: ValueKey(title.toString()),
                  textAlign: TextAlign.center,
                  style: CustomTextTheme(context: context).headLine(),
                )
              : const SizedBox(),
          titiling ? SizedBox(height: isSmall ? 5 : 15) : const SizedBox(),
          titiling
              ? Text(
                  subtitle ?? "",
                  textAlign: TextAlign.center,
                  style: CustomTextTheme(context: context).paragraph(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
