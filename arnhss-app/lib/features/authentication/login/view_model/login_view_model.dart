import 'package:arnhss/features/authentication/login/repo/login_service.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/otp_verify_view.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier with HandleException {
  final LoginService _loginService = LoginService();
  final TextEditingController _mobileNumberController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _myFocusNode = FocusNode();

  bool loading = false;

  TextEditingController get mobileNumberController => _mobileNumberController;
  ScrollController get scrollController => _scrollController;
  FocusNode get myFocusNode => _myFocusNode;

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

  void toggleLoading() {
    // print(loading);
    loading = !loading;
    notifyListeners();
  }

// get otp functionality
  void getOtp(BuildContext context, {bool reGet = false}) async {
    final String phoneNumber =
        CountryViewModel().selectedCountry.dialCode.toString() +
            mobileNumberController.text.toString();

    debugPrint(phoneNumber);
    final provider = context.read<VerifyOtpViewModel>();

    if (provider.isFirstReq || provider.resendAvailable) {
      toggleLoading();
      var status = await _loginService.getOtp(
        phone: mobileNumberController.text,
        countryCode: context.read<CountryViewModel>().selectedCountry.dialCode,
      );
      toggleLoading();

      if (status != null && !reGet) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(OtpVerificationView.routeName);
      }
    }

    await provider.startTimer();

    if (reGet) {
      provider.resetTimer();
    }
    provider.isFirstReq = false;
    debugPrint("start timer");
  }
}
