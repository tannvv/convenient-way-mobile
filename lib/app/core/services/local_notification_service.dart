import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';

class LocalNotificationService {
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'default_cw_chanel', // id
      'Kênh mặc định', // title
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('sound_notification'),
      playSound: true);

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await Permission.notification.isDenied.then((isDenied) {
      if (isDenied) Permission.notification.request();
    });
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    var androidInitialize = const AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showNotification({
    var id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('default_cw_chanel', 'Kênh mặc định',
            priority: Priority.defaultPriority,
            importance: Importance.defaultImportance,
            playSound: true,
            category: AndroidNotificationCategory.message,
            sound: RawResourceAndroidNotificationSound('sound_notification'),
            styleInformation: BigTextStyleInformation(''));

    var notify = const NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(id, title, body, notify,
        payload: payload);
  }

  static Future<void> showCallingNotification({
    var id = 2,
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('call_cw_chanel', 'Kênh mặc định',
            category: AndroidNotificationCategory.call,
            priority: Priority.max,
            importance: Importance.max,
            autoCancel: false,
            fullScreenIntent: true,
            timeoutAfter: 20000,
            actions: [
              AndroidNotificationAction('accept', 'Đồng ý',
                  icon: DrawableResourceAndroidBitmap('ic_accept_call'),
                  contextual: true,
                  titleColor: AppColors.green),
              AndroidNotificationAction('reject', 'Từ chối',
                  icon: DrawableResourceAndroidBitmap('ic_reject_call'),
                  contextual: true,
                  titleColor: AppColors.softRed)
            ],
            sound: RawResourceAndroidNotificationSound('ringtone_default'),
            styleInformation: BigTextStyleInformation(''));

    var notify = const NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(id, title, body, notify,
        payload: payload);
  }

  // @pragma('vm:entry-point')
  // static void notificationTapBackground(
  //     NotificationResponse notificationResponse) {
  //   debugPrint(
  //       'notificationTapBackground : ${notificationResponse.payload}, ${notificationResponse.id}, ${notificationResponse.input}');
  // }

  // static void onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) {
  //   debugPrint(
  //       'onDidReceiveNotificationResponse : ${notificationResponse.payload}, ${notificationResponse.id}, ${notificationResponse.input}');
  // }
}
