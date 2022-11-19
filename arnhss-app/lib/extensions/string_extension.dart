import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

extension StringExtension on String {
  Text toText({TextStyle? style}) {
    return Text(
      this,
      style: style,
    );
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
