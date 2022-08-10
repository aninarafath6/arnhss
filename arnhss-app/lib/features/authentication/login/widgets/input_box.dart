import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: TextField(
          focusNode: context.watch<LoginViewModel>().myFocusNode,
          onTap: () {
            context.read<LoginViewModel>().scrollToBottom();
          },
          controller: context.read<LoginViewModel>().mobileNumberController,
          keyboardType: TextInputType.number,
          cursorColor: CustomColors.dark,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your mobile number",
          ),
        ),
      ),
    );
  }
}
