import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:intl/intl.dart';

extension TimeFrom on TimeOfDay {
  String frm() {
    var pref = hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $pref";
  }
}

extension DateFrom on DateTime {
  String dtFrm({e = 'EEEE,', d = " dd", m = " MMMM ", y = ""}) {
    DateFormat formatter = DateFormat(e + d + m + y);

    return formatter.format(this).toString();
  }
}
