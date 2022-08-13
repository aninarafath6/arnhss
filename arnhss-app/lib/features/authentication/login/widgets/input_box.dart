import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  late FocusNode myFocusNode = context.read<LoginViewModel>().myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: TextField(
          controller: context.read<LoginViewModel>().mobileNumberController,
          focusNode: myFocusNode,
          keyboardType: TextInputType.number,
          cursorColor: CustomColors.dark,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your mobile number",
            hintStyle: CustomTextTheme(context: context).paragraph(),
          ),
        ),
      ),
    );
  }
}
