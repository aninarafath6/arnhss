import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

//* initialize notification method
  static Future<void> initialize() async {
    const InitializationSettings _initializeSettings = InitializationSettings(
        android: AndroidInitializationSettings("ic_stat_logo"));
    await _notificationsPlugin.initialize(_initializeSettings);
  }

//* display firebase notification
  static void firePlay(RemoteMessage message) {
    try {
      int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'arnhss_108020', // id
            'arnhss_108020', // id
            // 'This channel is used for important notifications.', // description
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    } catch (e) {
      log(e.toString(), name: "firePlay");
    }
  }

//* display dummy notification
  static void display(String title, String body) {
    try {
      int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _notificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'arnhss_108020', // id
            'arnhss_108020', // id
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    } catch (e) {
      log(e.toString(), name: "display");
    }
  }
}
