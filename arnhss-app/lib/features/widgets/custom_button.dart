import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.color = CustomColors.dark,
      this.onTap,
      this.label = "Get Started"})
      : super(key: key);

  final Color color;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => color.withOpacity(.1)),
      ),
      onPressed: onTap,
      child: Container(
        width: context.getWidth(100),
        height: context.getHeight(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            context.getHeight(1),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
