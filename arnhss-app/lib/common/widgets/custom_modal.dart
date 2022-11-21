import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:flutter/cupertino.dart';

Future<dynamic> customModal(
  BuildContext context, {
  required content,
  Widget done = const Text("CONTINUE"),
  String deny = "EDIT",
  String? title,
  VoidCallback? onDone,
  VoidCallback? onDeny,
  bool loading = false,
  Widget? loadingWidget,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? ""),
        content: Text(
          content,
          style: CustomTextTheme(context: context).paragraph(),
        ),
        actions: [
          TextButton(onPressed: onDeny, child: Text(deny)),
          TextButton(
            onPressed: onDone,
            child: loading
                ? const CupertinoActivityIndicator(
                    color: CustomColors.dark,
                  )
                : done,
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}
