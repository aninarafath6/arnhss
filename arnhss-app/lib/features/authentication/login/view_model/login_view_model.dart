import 'package:arnhss/features/authentication/login/repo/login_service.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/otp_verify_view.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
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

//* validate
  bool validate() {
    // * mobile number regular expression pattern
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    //* regExp
    RegExp regExp = RegExp(pattern);
    //* handling errors
    try {
      // * if mobile number is empty then throw a invalid exception
      if (_mobileNumberController.text.isEmpty) {
        throw InvalidException("Please enter your mobile number! ", false);
      } else {
        if (regExp.hasMatch(_mobileNumberController.text)) {
          return true;
        } else {
          throw InvalidException("Please enter valid mobile number!", false);
        }
      }
    } catch (e) {
      handleException(e);
      return false;
    }
  }

  // bool otpDialog() {}

//* toggle loading
  void toggleLoading() {
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
      await Future.delayed(const Duration(milliseconds: 800));
      var status = true;
      // TODO: login service implimentaition needed

      if (status && !reGet) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(OtpVerificationView.routeName);
      }
      toggleLoading();
    }

    await provider.startTimer();

    if (reGet) {
      provider.resetTimer();
    }
    provider.isFirstReq = false;
    // Navigator.pop(context);
    // Navigator.of(context).pushNamed(OtpVerificationView.routeName);

    debugPrint("start timer");
  }
}
