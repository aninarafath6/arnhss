import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
    this.imageURL,
    this.title,
    this.subTitle,
  }) : super(key: key);
  final String? imageURL;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Center(
          child: Image.asset(
            imageURL ?? Images.notificationNotFound,
            width: 200,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title ?? "",
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(color: CustomColors.dark.withOpacity(.8)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 3),
        Text(
          subTitle ?? "",
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 13),
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
