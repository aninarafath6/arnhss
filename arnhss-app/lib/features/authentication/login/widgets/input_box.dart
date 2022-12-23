import 'dart:async';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_button.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/utils/scroll.util.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class InputFelid extends StatelessWidget {
  const InputFelid({
    Key? key,
    this.hintText = "Enter your mobile number",
  }) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      height: context.isMobile ? 55 : 50,
      decoration: BoxDecoration(
          color: CustomColors.lightBgOverlay,
          borderRadius: BorderRadius.circular(8)),
      child:  CustomInput(hintText: hintText,),
    );
  }
}

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
    this.hintText = "Enter your mobile number",
  }) : super(key: key);
  final String hintText;
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
            // if (!context.isKeyboard) {
            //   ScrollUtil().scroll(
            //       controller: context.read<LoginViewModel>().scrollController);
            // }
          },
          keyboardType: TextInputType.number,
          cursorColor: CustomColors.dark,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: CustomTextTheme(context: context)
                .paragraph()
                .copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
