import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.color = CustomColors.dark,
    this.height = 80,
    this.textColor = CustomColors.white,
    this.width = double.infinity,
    this.onTap,
    this.fontSize = 15,
    this.label = "Get Started",
    this.fontWeight = FontWeight.w500,
    this.isDisabled = false,
    this.nonActiveColor = CustomColors.light,
    this.loading = false,
    this.elevation = true,
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

  final bool elevation;

  /// [color] is not required because there is default color , it  used to color of background

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height - 20,
      child: Material(
        child: TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith(
                (states) => elevation ? 5 : 0),
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => CustomColors.buttonSplash),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => isDisabled ? nonActiveColor : color),
          ),
          onPressed: isDisabled || loading ? null : onTap,
          child: Container(
            // width: width,
            // height: height,
            decoration: BoxDecoration(
              // color: isDisabled ? nonActiveColor : color,
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
      ),
    );
  }
}
