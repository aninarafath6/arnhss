import 'dart:async';

import 'package:flutter/material.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  void resendTimer() {
    const Duration lim = Duration(seconds: 60);
    Timer timer = Timer.periodic(lim, (timer) {
      print(lim);
    });
  }
}
