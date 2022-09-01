import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:flutter/material.dart';

class QoutOfTheDay extends StatelessWidget {
  const QoutOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CustomColors.dark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: .1,
            child: Image.asset(
              "assets/images/pngs/right-quote-sign.png",
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We cannot solve our problems with the same thinking we used when we created them....",
                  style: CustomTextTheme(context: context).paragraph().copyWith(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "- Albert Einstein",
                      style: CustomTextTheme(context: context)
                          .paragraph()
                          .copyWith(
                              color: Colors.grey[400],
                              fontStyle: FontStyle.italic),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
