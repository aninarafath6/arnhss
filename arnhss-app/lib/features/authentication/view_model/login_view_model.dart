import 'package:arnhss/features/authentication/otp_verification/views/otp_verify_view.dart';
import 'package:arnhss/features/authentication/view_model/verify_otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController _mobileNumberController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _myFocusNode = FocusNode();

  TextEditingController get mobileNumberController => _mobileNumberController;
  ScrollController get scrollController => _scrollController;
  FocusNode get myFocusNode => _myFocusNode;
// scroll when keybord is shown
  scrollToBottom() {
    final contentSize = _scrollController.position.viewportDimension +
        _scrollController.position.maxScrollExtent;
    _scrollController.position.animateTo(
      contentSize / 7,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

// a popup for validate mobile number
  bool otpDialog() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(_mobileNumberController.text)) {
      return true;
    } else {
      return false;
    }
  }

// get otp functionality
  void getOtp(BuildContext context, {bool reGet = false}) {
    final provider = context.read<VerifyOtpViewModel>();

    if (provider.isFirstReq) {
      provider.verifyOtp(int.parse(_mobileNumberController.text));
      print("get otp with ${_mobileNumberController.text}");
    } else if (!provider.isFirstReq && provider.resendAvailable) {
      provider.verifyOtp(int.parse(_mobileNumberController.text));
      print(
          "get otp with ${_mobileNumberController.text} after waiting for resend");
    } else {
      print("try after ${provider.balanceTime} seconds");
    }
  }
}
