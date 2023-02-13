import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'convenient.way.notification', // id
    'Convenient way for delivering application', // title
    description: 'Convenient copy right', // description
    importance: Importance.max,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint(
            'Notification: Foreground message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
        showNotification(
            title: message.notification?.title,
            body: message.notification?.body);
      },
    );
  }

  static Future<void> showNotification({
    var id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
            'channel_id 1', // id
            'Convenient way for delivering application', // title
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(''));

    var notify = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(id, title, body, notify,
        payload: payload);
  }
}
