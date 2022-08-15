import 'dart:async';

import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/authentication/otp_verification/widgets/success_screen.dart';
import 'package:arnhss/features/widgets/custom_snack_bar.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  int _balanceTime = 30;
  bool _isFirstReq = true;
  final ScrollController _otpScrollController = ScrollController();
  String? _otp;
  bool _isLoading = false;

  // getters
  int get balanceTime => _balanceTime;
  bool get resendAvailable => _balanceTime == 0 ? true : false;
  bool get isFirstReq => _isFirstReq;
  ScrollController get otpScrollController => _otpScrollController;
  String? get otp => _otp;
  bool get isLoading => _isLoading;

//setters
  void setOtp(String? otp) {
    _otp = otp;
    notifyListeners();
  }

  set isFirstReq(bool status) => (_isFirstReq = status);

  // functions
// reset the timer
  void resetTimer() {
    _balanceTime = 60;
    _isFirstReq = false;
    notifyListeners();
  }

  void updateLoading() {
    _isLoading = !_isLoading;
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
  Future<bool> verifyOtp(BuildContext context) async {
    if (_otp!.length == 5 && num.tryParse(_otp!) != null) {
      debugPrint("verifying otp");

      updateLoading();
      // implimentation of api call
      try {} catch (e) {}
      // loading just for ui test
      await Future.delayed(const Duration(seconds: 3));

      updateLoading();
      return true;
    } else {
      debugPrint("invalid otp");
      customSnackBar(context, "sorry 😞, Please enter valid OTP");
      return false;
    }
  }

//   // handle verify OTP and
//   void handleVerifyOtp(BuildContext context) {
//     () {
//       if (context.read<VerifyOtpVi  SuccessScreen(context);
//         Timer(
//           const Duration(seconds: 3),
//           () {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, "/userRole", (r) => false);
//           },
//         );
//       } else {
//         customSnackBar(context, "sorry 😞, Please enter valid OTP");
//       }
//     };
//   }
}
