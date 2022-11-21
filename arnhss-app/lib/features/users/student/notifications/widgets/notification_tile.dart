import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/users/student/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    this.notification,
    this.onDismiss,
  }) : super(key: key);
  final NotificationModel? notification;
  final Function(DismissDirection)? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification?.id! ?? ""),
      onDismissed: onDismiss!,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: ListTile(
          title: Text(notification?.title ?? ""),
          subtitle: Text(notification?.subTitle ?? ""),
          leading: CircleAvatar(
            backgroundColor: CustomColors.lightBgOverlay,
            child: Center(
              child: Icon(
                notification?.icon ?? (Remix.notification_3_line),
                size: 18,
                color: CustomColors.light,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
