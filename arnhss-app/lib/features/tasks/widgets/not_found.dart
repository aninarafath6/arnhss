import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Container(
            // height: 350,
            // width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Center(
              child: Image.asset(Images.notFound),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "No plans for this day",
            style: CustomTextTheme(context: context).paragraph(),
          ),
          const SizedBox(height: 10),
          // Text(
          //   "looks like you haven't made your plans yet",
          //   style: CustomTextTheme(context: context).paragraph(),
          //   textAlign: TextAlign.center,
          // ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
