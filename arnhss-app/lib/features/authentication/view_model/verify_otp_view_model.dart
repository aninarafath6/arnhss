import 'dart:async';

import 'package:flutter/material.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  int _balanceTime = 60;

  int get balanceTime => _balanceTime;

  void resendTimer() {
    print("resendTimer");
    const Duration lim = Duration(seconds: 1);
    Timer timer = Timer.periodic(lim, (timer) {
      if (_balanceTime == 0) {
        timer.cancel();
      } else {
        _balanceTime--;
        print(_balanceTime);
        notifyListeners();
      }
    });
  }
}
