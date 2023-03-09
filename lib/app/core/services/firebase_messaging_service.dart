import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/core/services/local_notification_service.dart';
import 'package:tien_duong/app/data/constants/notification_type.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  static FirebaseMessagingService get instance => _instance;
  FirebaseMessagingService._internal();

  static Future<String?> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('Token firebase messaging: $fcmToken');
    return fcmToken;
  }

  static Future<void> init() async {
    debugPrint('FCM token: ${await getToken()}}');
    FirebaseMessaging.onMessage.listen(firebaseForegroundHandler);
    FirebaseMessaging.onBackgroundMessage(
        FirebaseMessagingService.firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint(
        'Notification: Background message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
    // LocalNotificationService.showCallingNotification(
    //     title: 'Cuộc gọi đến', body: 'Tân Nguyễn đang gọi cho bạn');

    if (message.data['typeOfNotification'] != TypeOfNotification.TRACKING) {
      LocalNotificationService.showNotification(
          title: message.notification?.title, body: message.notification?.body);
    }
  }

  static Future<void> firebaseForegroundHandler(RemoteMessage message) async {
    debugPrint(
        'Notification: Foreground message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');

    if (message.data['typeOfNotification'] != TypeOfNotification.TRACKING) {
      LocalNotificationService.showNotification(
          title: message.notification?.title, body: message.notification?.body);
    }
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
