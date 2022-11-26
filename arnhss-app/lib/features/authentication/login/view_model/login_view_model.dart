import 'package:arnhss/abstract/loader.abstract.dart';
import 'package:arnhss/common/constants/firebase_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/extensions/enum_extension.dart';

import 'package:arnhss/features/authentication/repo/auth_service.dart';
import 'package:arnhss/features/authentication/login/view_model/country_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/otp_verify_view.dart';
import 'package:arnhss/features/authentication/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends Loader with HandleException {
  // * instances
  final AuthService _authService = AuthService();
  // final VerifyOtpViewModel _verifyOtpViewModel = VerifyOtpViewModel();

  // * controllers
  final TextEditingController _mobileNumberController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _myFocusNode = FocusNode();
  Role? _userRole;

  bool loading = false;
  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  String _verificationId = "";
  int? resentToken;

  //* getters
  TextEditingController get mobileNumberController => _mobileNumberController;
  ScrollController get scrollController => _scrollController;
  FocusNode get myFocusNode => _myFocusNode;
  // bool get loading => _loading;
  String get vi => _verificationId;
  Role? get getUserRole => _userRole;

  //* setters
  set setUserRole(Role role) {
    _userRole = role;
    notifyListeners();
  }

//* validate
  bool validate() {
    // * mobile number regular expression pattern
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    //* regExp
    RegExp regExp = RegExp(pattern);
    //* handling errors
    try {
      _mobileNumberController.text = _mobileNumberController.text.trim();
      // _mobileNumberController.text = _mobileNumberController.text.trim();

      // * if mobile number is empty then throw a invalid exception
      if (_mobileNumberController.text.isEmpty) {
        throw InvalidException("Please enter your mobile number! ", false);
      } else {
        if (regExp.hasMatch(_mobileNumberController.text)) {
          if (_userRole == null) {
            throw InvalidException("Please select your Role! ", false);
          } else {
            return true;
          }
        } else {
          throw InvalidException("Please enter valid mobile number!", false);
        }
      }
    } catch (e) {
      handleException(e);
      return false;
    }
  }

// //* toggle loading
//   void toggleLoading() {
//     loading = !loading;
//     notifyListeners();
//   }

// get otp functionality
  void getOtp(BuildContext context,
      {bool reGet = false, bool req = false}) async {
    // * phone number from mobile number input controller
    final String phoneNumber = mobileNumberController.text.trim().toString();

    // * provider
    final provider = context.read<VerifyOtpViewModel>();

/*
  * we can send otp if this is first request
  * or we can send otp when the balance time is 0 that means the resendAvailable is true 
 */
    toggleLoading();
    if (provider.isFirstReq || provider.resendAvailable || req) {
      // * start loading
      var status = true;
      await _authService
          .getOtp(
            // * phone number
            phone: phoneNumber,
            // * country code
            countryCode:
                context.read<CountryViewModel>().selectedCountry.dialCode,
            codeSent: (String vi, int? token) {
              _verificationId = vi;
              resentToken = token;
              // * navigate to otp screen when the otp sent
              if (status && !reGet) {
                Get.back();
                Get.toNamed(OtpVerificationView.routeName);
              }
              // * stop loading actions indicator
              toggleLoading();
            },
            verificationFailed: (FirebaseAuthException error) {
              loading = false;
              Get.back();
              handleException(error);
            },
            // * time out handler
            timeout: provider.duration,
            resentToken: resentToken,
          )
          // * handle error
          .catchError((value) => handleException(value));
    }

    // * restart the timer
    await provider.startTimer();
    // * if the this is re get for  otp then restart the timer.
    if (reGet) {
      provider.resetTimer();
    }
    // * set the first req into false
    provider.isFirstReq = false;
  }

  Future<void> logout(UserModel? user) async {
    toggleLoading();
    await Future.delayed(const Duration(milliseconds: 400));

    await _authService.logout(user);
    FirebaseMessaging.instance.unsubscribeFromTopic(user?.role?.describe ?? "");
  FirebaseMessaging.instance
        .unsubscribeFromTopic(FirebaseConstants.authenticatedUSERS);
    FirebaseMessaging.instance.unsubscribeFromTopic(Role.everyone.describe);

    toggleLoading();
  }

  void disposeLogin() {
    // print("login dispose method");
    _mobileNumberController.text = "";
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }
}
