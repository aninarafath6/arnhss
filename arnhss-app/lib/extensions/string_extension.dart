import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

extension StringExtension on String {
  Text toText({TextStyle? style}) {
    return Text(
      this,
      style: style,
    );
  }

  String get capitalize {
    List<String> sliced = split(" ");

    return sliced
        .map((e) {
          return "${e[0].toUpperCase()}${e.substring(1).toLowerCase()}";
        })
        .join(" ")
        .toString();
  }
}
