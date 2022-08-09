import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputBox extends StatelessWidget {
  InputBox({
    Key? key,
  }) : super(key: key);
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: TextField(
          focusNode: myFocusNode,
          onTap: () {
            !myFocusNode.hasFocus
                ? context.read<LoginViewModel>().scrollToBottom()
                : null;
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
