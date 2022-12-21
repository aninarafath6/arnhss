import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QoutOfTheDay extends StatelessWidget {
  const QoutOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(18),
      // margin: const EdgeInsets.symmetric(horizontal: AppSizes.default_padding),
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Positioned(
            // alignment: Alignment.topLeft,
            top: 15,
            child: Opacity(
              opacity: .1,
              child: Image.asset(
                "assets/images/pngs/right-quote-sign.png",
                color: Colors.black.withOpacity(.7),
                width: 80,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Text(
                  "We cannot solve our problems with the same thinking we used when we created them....",
                  maxLines: 3,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "- Albert Einstein",
                      style: GoogleFonts.breeSerif(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "Today - Anin Arafath ",
                      style: GoogleFonts.baloo2(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        // fontStyle: FontStyle.italic,
                      ),
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
