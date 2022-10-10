import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

extension TimeFrom on TimeOfDay {
  String frm() {
    var pref = hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $pref";
  }
}
