import 'dart:async';

import 'package:flutter/material.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  int _balanceTime = 60;
  bool _isFirstReq = true;

  int get balanceTime => _balanceTime;
  bool get resendAvailable => _balanceTime == 0 ? true : false;
  bool get isFirstReq => _isFirstReq;

// reset the timer
  void resetTimer() {
    _balanceTime = 60;

    notifyListeners();
    _isFirstReq = false;
  }

// the time for resend the otp
  void resendTimer() {
    const Duration lim = Duration(seconds: 1);
    Timer.periodic(
      lim,
      (timer) {
        if (_balanceTime == 0) {
          timer.cancel();
        } else {
          _balanceTime--;
          notifyListeners();
        }
      },
    );
  }

  void verifyOtp(int code) {
    print("verify otp with $code");
  }
}
