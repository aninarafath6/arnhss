import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
    this.imageURL,
    this.title,
  }) : super(key: key);
  final String? imageURL;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        SizedBox(
          width: 200,
          child: Center(
            child: Image.asset(Images.notFound),
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 3),
        Text(
          "No plans for this date",
          style: CustomTextTheme(context: context).paragraph(),
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
