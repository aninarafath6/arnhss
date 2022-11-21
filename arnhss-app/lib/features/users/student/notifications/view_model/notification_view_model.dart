import 'package:arnhss/features/users/student/notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class NotificationViewModel with ChangeNotifier {
  // ! dummy pre defined notifications
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: "1",
      title: "Sunday is holiday",
      subTitle:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      icon: Remix.bit_coin_line,
    ),
    NotificationModel(
      id: "2",
      title: "You have been marked as absent",
      subTitle:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      icon: Remix.bubble_chart_line,
    ),
  ];

  // * getters
  List<NotificationModel> get notifications => _notifications;
  int get notificationCount => _notifications.length;

  dismissNotification(String id) {
    _notifications.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
