import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
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
    this.isDisabled = false,
    this.nonActiveColor = CustomColors.light,
    this.loading = false,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function()? onTap;
  final double width;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final bool isDisabled;
  final Color nonActiveColor;
  final bool loading;

  /// [color] is not required because there is defualt color , it  used to color of backouround

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => color.withOpacity(.1)),
        ),
        onPressed: isDisabled ? null : onTap,
        child: Container(
          width: context.getWidth(width),
          height: context.getHeight(height),
          decoration: BoxDecoration(
            color: isDisabled ? nonActiveColor : color,
            borderRadius: BorderRadius.circular(
              context.getHeight(1),
            ),
          ),
          child: Center(
            child: loading
                ? const CupertinoActivityIndicator(
                    color: CustomColors.white,
                  )
                : Text(
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
