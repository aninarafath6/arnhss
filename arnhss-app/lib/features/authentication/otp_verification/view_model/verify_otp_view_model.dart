import 'dart:async';

import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/success_screen.dart';
import 'package:arnhss/features/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  int _balanceTime = 30;
  bool _isFirstReq = true;
  final ScrollController _otpScrollController = ScrollController();
  String? _otp;

  // getters
  int get balanceTime => _balanceTime;
  bool get resendAvailable => _balanceTime == 0 ? true : false;
  bool get isFirstReq => _isFirstReq;
  ScrollController get otpScrollController => _otpScrollController;
  String? get otp => _otp;

//setters
  set setOtp(String? otp) => (_otp = otp);
  set isFirstReq(bool status) => (_isFirstReq = status);

  // functions
// reset the timer
  void resetTimer() {
    _balanceTime = 60;
    _isFirstReq = false;
    notifyListeners();
  }

// the time for resend the otp
  Future<void> startTimer() async {
    const Duration lim = Duration(seconds: 1);
    Timer.periodic(lim, (timer) {
      if (_balanceTime == 0) {
        timer.cancel();
      } else {
        _balanceTime--;
        notifyListeners();
      }
    });
  }

// validate the otp by api
  bool verifyOtp() {
    if (_otp!.length == 5 && num.tryParse(_otp!) != null) {
      debugPrint("verifying otp");
      return true;
    } else {
      debugPrint("invalid otp");
      return false;
    }
  }

  // handle veriyOtp and
  void handleVerifyOtp(BuildContext context) {
    () {
      if (context.read<VerifyOtpViewModel>().verifyOtp()) {
        SuccessScreen(context);
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/userRole", (r) => false);
          },
        );
      } else {
        customSnackBar(context, "sorry 😞, Please enter valid OTP");
      }
    };
  }
}
