import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Center(
      child: TextField(
        keyboardType: TextInputType.number,
        cursorColor: CustomColors.dark,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your mobile number",
        ),
      ),
    ));
  }
}
