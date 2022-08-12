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

  scrollToBottom() {
    final contentSize = _scrollController.position.viewportDimension +
        _scrollController.position.maxScrollExtent;
    _scrollController.position.animateTo(
      contentSize / 7,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  bool otpDialog() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(_mobileNumberController.text)) {
      return true;
    } else {
      return false;
    }
  }

  void getOtp(BuildContext context) {
    context.read<VerifyOtpViewModel>().resendTimer();
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      OtpVerificationView.routeName,
    );
  }
}
