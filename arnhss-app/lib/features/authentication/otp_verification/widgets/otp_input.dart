import 'dart:async';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/view_model/verify_otp_view_model.dart';
import 'package:arnhss/utils/scroll.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();
    subscription = KeyboardVisibilityController().onChange.listen((open) {
      if (open) {
        ScrollUtil().scroll(
          controller: context.read<VerifyOtpViewModel>().otpScrollController,
          pos: 3,
        );
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
    return OtpTextField(
      focusedBorderColor: CustomColors.dark,
      keyboardType: TextInputType.number,
      numberOfFields: 5,
      showFieldAsBox: true,
      autoFocus: false,
      clearText: true,
      onSubmit: (otp) => context.read<VerifyOtpViewModel>().setOtp = otp,
    );
  }
}
