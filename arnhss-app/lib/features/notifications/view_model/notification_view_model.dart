import 'package:arnhss/features/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class NotificationViewModel with ChangeNotifier {
  List<NotificationModel> notifications = [
    NotificationModel(
      title: "Sunday is holiday",
      subTitle:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      icon: Remix.bit_coin_line,
    ),
    NotificationModel(
      title: "You have been marked as absent",
      subTitle:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      icon: Remix.bubble_chart_line,
    ),
  ];
}
