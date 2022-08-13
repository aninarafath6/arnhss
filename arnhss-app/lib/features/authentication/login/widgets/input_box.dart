import 'dart:async';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/view_model/login_view_model.dart';
import 'package:arnhss/utils/dimensions.dart';
import 'package:arnhss/utils/scroll.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();
    subscription = KeyboardVisibilityController().onChange.listen((open) {
      if (open) {
        ScrollUtil().scroll(
            controller: context.read<LoginViewModel>().scrollController);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: TextField(
          controller: context.read<LoginViewModel>().mobileNumberController,
          onTap: () {
            if (!context.isKeyboard) {
              ScrollUtil().scroll(
                  controller: context.read<LoginViewModel>().scrollController);
            }
          },
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
