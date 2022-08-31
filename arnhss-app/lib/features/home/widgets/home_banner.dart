import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hey,",
          style: GoogleFonts.firaSans(
            fontSize: 28,
            color: CustomColors.dark,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Anin Arafath 👋🏻",
          style: GoogleFonts.firaSans(
            fontSize: 32,
            color: CustomColors.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Sunday, March 25th",
          style: GoogleFonts.firaSans(
            fontSize: 14,
            color: CustomColors.dark.withOpacity(.5),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
