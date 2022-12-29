import 'dart:async';

import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/features/authentication/repo/auth_service.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  // * instances
  final AuthService _authService = AuthService();
  AuthCredential? _authCredential;

  int duration = 30;
  int _balanceTime = 30;
  bool _isFirstReq = true;
  final ScrollController _otpScrollController = ScrollController();
  String? _otp;
  bool _isLoading = false;
  Timer? timer;

  void disp() {
    _otp = null;
    timer?.cancel();
    notifyListeners();
  }

  //* getters
  int get balanceTime => _balanceTime;
  bool get resendAvailable => _balanceTime == 0 ? true : false;
  bool get isFirstReq => _isFirstReq;
  ScrollController get otpScrollController => _otpScrollController;
  String? get otp => _otp;
  bool get isLoading => _isLoading;
  AuthCredential? get authCredential => _authCredential;

//* setters
  void setOtp(String? otp) {
    _otp = otp;
    notifyListeners();
  }

  set isFirstReq(bool status) => (_isFirstReq = status);

// * reset timer
  void resetTimer() {
    duration = 60;
    _balanceTime = 60;
    _isFirstReq = false;
    notifyListeners();
  }

// * toggle loading
  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

// * the time for resend the otp
  Future<void> startTimer() async {
    debugPrint("started");
    const Duration lim = Duration(seconds: 1);
    timer = Timer.periodic(lim, (timer) {
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
    if (_otp!.length == 6 && num.tryParse(_otp!) != null) {
      debugPrint("verifying otp");
      toggleLoading();

      // * verify otp with firebase credential
      return await _authService
          .verifyOtp(
        vi: context.read<LoginViewModel>().vi,
        otp: _otp,
        callback: () {
          toggleLoading();
        },
        errorCallback: (e) {
          toggleLoading();

          DialogHelper.showErrorDialog(
            title: "Sorry,👾",
            description: e.code ?? "OTP Verification is failed",
            top: true,
          );
        },
      )
          .catchError(
        (_) {
          toggleLoading();
        },
      );

      // if (_authCredential != null) {
      //   print(_authCredential);
      //   toggleLoading();
      //   // return true;
      // }
      // toggleLoading();
      // return false;
    } else {
      debugPrint("invalid otp");
      customSnackBar(content: "sorry 😞, Please enter valid OTP");
      return false;
    }
  }
}
