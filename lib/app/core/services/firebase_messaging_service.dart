import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tien_duong/app/core/services/local_notification_service.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  static FirebaseMessagingService get instance => _instance;
  FirebaseMessagingService._internal();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<String?> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('Token firebase messaging: $fcmToken');
    return fcmToken;
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint(
        'Notification: Background message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
    LocalNotificationService.showNotification(
        title: message.notification?.title, body: message.notification?.body);
  }

  static Future<void> registerNotification(String accountId) async {
    await FirebaseMessaging.instance.subscribeToTopic('all').then((_) {
      debugPrint('Notification: Subscribed to topic: all');
    });
    await FirebaseMessaging.instance.subscribeToTopic(accountId).then((_) {
      debugPrint('Notification: Subscribed to topic: $accountId');
    });
  }

  static Future<void> unregisterNotification(String accountId) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all').then((_) {
      debugPrint('Notification: Unsubscribed from topic: all');
    });
    await FirebaseMessaging.instance.unsubscribeFromTopic(accountId).then((_) {
      debugPrint('Notification: Unsubscribed from topic: $accountId');
    });
  }
}
