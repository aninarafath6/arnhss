import 'dart:developer';

import 'package:arnhss/common/constants/network_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/services/base/base_client.dart';
import 'package:arnhss/services/notification/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static BaseClient _baseClient =
      BaseClient(baseURL: NetworkConstants.baseFcmURL);
  Future<void> setupInteractedMessage(BuildContext context) async {
    //* this function will work while app is still background.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) => _handleMessage(message, context));

    //* only work when the app is working on foreground
    //* this will not work on background
    FirebaseMessaging.onMessage
        .listen((RemoteMessage? message) => _handleMessage(message, context));

    //* Also handle any interaction when the app is in the background via a
    //* Stream listener
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage? message) => _handleMessage(message, context));
  }

  //* handle the notification message
  void _handleMessage(RemoteMessage? message, BuildContext context) {
    log(message?.notification?.title ?? "");
    log(message?.notification?.body ?? "");

    //* if the notification message have routeName then navigate to that page

    if (message != null) {
      LocalNotificationService.firePlay(message);
      String? _routeName = message.data['route'];
      if (_routeName != null) {
        Navigator.of(context).pushNamed(_routeName);
      }
    }
  }

  Future<void> sendTopicPushNotification(
    String topic,
    String title,
    String body,
  ) async {
    final data = {
      "to": "/topics/$topic",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": 28,
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final _header = {
      'content-type': "application/json",
      'Authorization':
          "key=AAAAqKTeGbA:APA91bFvKXGVvd46ecTXlVLq84pFU-kCYM3Jk8LKrhxcE6bZqDRskMCnfuw4rrbRRObHMbECrMEf61J7VrkjJZQsI94NKDY5E6Ic0AfKgmnqbbymSTbnQ5fWMZB0XLGqkVTlvR1DcKCF"
    };
    final result = await _baseClient.post("fcm/send", data, header: _header);
    print(result);
  }
}
