import 'dart:async';

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
  void verifyOtp() {
    print("verify otp with $_otp ");
  }
}
