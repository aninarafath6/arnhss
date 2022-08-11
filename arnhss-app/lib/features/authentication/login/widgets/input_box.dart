import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
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
  late FocusNode myFocusNode = context.read<LoginViewModel>().myFocusNode;
  @override
  void initState() {
    super.initState();
    print("init");
    // super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        print("focus");
        context.read<LoginViewModel>().scrollToBottom();
      }
    });
  }

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
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your mobile number",
              hintStyle: CustomTextTheme(context: context).paragraph()),
        ),
      ),
    );
  }
}
