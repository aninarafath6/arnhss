import 'dart:ui';

import 'package:arnhss/abstract/loader.abstract.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/course_view_model.dart';
import 'package:arnhss/features/users/view_model/notice_view_model.dart';
import 'package:flutter/cupertino.dart';

Future<dynamic> noticeModal(BuildContext context,
    {required String content,
    required String title,
    String deny = 'EDIT',
    required Widget done,
    VoidCallback? onDeny,
    VoidCallback? onDone,
    bool isBlur = false}) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: isBlur ? 1 : 0, sigmaY: isBlur ? 1 : 0),
        child: AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: CustomTextTheme(context: context)
                .paragraph()
                .copyWith(fontSize: 15),
          ),
          actions: [
            TextButton(onPressed: onDeny, child: Text(deny)),
            TextButton(
              onPressed: onDone,
              child: Provider.of<NoticeViewModel>(context).loading
                  ? const CupertinoActivityIndicator(
                      color: CustomColors.dark,
                    )
                  : "SURE".toText(style: const TextStyle(color: Colors.red)),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    },
  );
}

Future<dynamic> loginModal(
  BuildContext context, {
  required String content,
  required String title,
  String deny = 'EDIT',
  required Widget done,
  VoidCallback? onDeny,
  VoidCallback? onDone,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 15),
        ),
        actions: [
          TextButton(onPressed: onDeny, child: Text(deny)),
          TextButton(
            onPressed: onDone,
            child: Provider.of<LoginViewModel>(context).loading
                ? const CupertinoActivityIndicator(
                    color: CustomColors.dark,
                  )
                : "SURE".toText(style: const TextStyle(color: Colors.red)),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}

Future<dynamic> courseModal(
  BuildContext context, {
  required String content,
  required String title,
  String deny = 'EDIT',
  required Widget done,
  VoidCallback? onDeny,
  VoidCallback? onDone,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 15),
        ),
        actions: [
          TextButton(onPressed: onDeny, child: Text(deny)),
          TextButton(
            onPressed: onDone,
            child: Provider.of<AdmissionViewModel>(context).getDeleteLoading
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

Future<dynamic> batchModal(
  BuildContext context, {
  required String content,
  required String title,
  String deny = 'EDIT',
  required Widget done,
  VoidCallback? onDeny,
  VoidCallback? onDone,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 15),
        ),
        actions: [
          TextButton(onPressed: onDeny, child: Text(deny)),
          TextButton(
            onPressed: onDone,
            child: Provider.of<CourseViewModel>(context).getDeleteLoading
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

customModal<T>(
  BuildContext context, {
  required String content,
  required String title,
  String deny = 'EDIT',
  String done = " SURE",
  VoidCallback? onDeny,
  VoidCallback? onDone,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content,
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 15),
        ),
        actions: [
          TextButton(onPressed: onDeny, child: Text(deny)),
          TextButton(
            onPressed: onDone,
            child: done.toText(
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}
