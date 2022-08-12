import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.color = CustomColors.dark,
    this.height = 5,
    this.textColor = CustomColors.white,
    this.width = double.infinity,
    this.onTap,
    this.fontSize = 15,
    this.label = "Get Started",
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function()? onTap;
  final double width;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => color.withOpacity(.1)),
        ),
        onPressed: onTap,
        child: Container(
          width: context.getWidth(width),
          height: context.getHeight(height),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              context.getHeight(1),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
