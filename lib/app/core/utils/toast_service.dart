import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';

class ToastService {
  static Future<dynamic> showSuccess(String description,
      {Text? title,
      AnimationType animationType = AnimationType.fromTop,
      NotificationPosition position = NotificationPosition.topCenter,
      int seconds = 3,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      double height = Get.height * 0.06;
      if (description.length > 20) {
        height = Get.height * 0.08;
      } else if (description.length > 40) {
        height = Get.height * 0.12;
      }
      ElegantNotification.success(
        width: 260.w,
        height: height,
        notificationPosition: position,
        animation: animationType,
        description: Text(
          description,
          style: descriptionStyle ?? subtitle2,
        ),
        toastDuration: Duration(seconds: seconds),
        showProgressIndicator: true,
        title: title,
      ).show(context);
    }
  }

  static Future<dynamic> showError(String description,
      {Text? title,
      AnimationType animationType = AnimationType.fromTop,
      NotificationPosition position = NotificationPosition.topCenter,
      int seconds = 3,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      double height = Get.height * 0.06;
      if (description.length > 20) {
        height = Get.height * 0.08;
      } else if (description.length > 40) {
        height = Get.height * 0.12;
      } else if (description.length > 60) {
        height = Get.height * 0.4;
      }
      ElegantNotification.error(
        width: 260.w,
        height: height,
        notificationPosition: position,
        animation: animationType,
        description: Text(
          description,
          style: descriptionStyle ?? subtitle2,
        ),
        toastDuration: Duration(seconds: seconds),
        showProgressIndicator: true,
        title: title,
      ).show(context);
    }
  }

  static Future<dynamic> showInfo(String description,
      {Text? title,
      AnimationType animationType = AnimationType.fromTop,
      NotificationPosition position = NotificationPosition.topCenter,
      int seconds = 3,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      double height = Get.height * 0.06;
      if (description.length > 20) {
        height = Get.height * 0.08;
      } else if (description.length > 40) {
        height = Get.height * 0.12;
      }
      ElegantNotification.info(
        width: 260.w,
        height: height,
        notificationPosition: position,
        animation: animationType,
        description: Text(
          description,
          style: descriptionStyle ?? subtitle2,
        ),
        toastDuration: Duration(seconds: seconds),
        showProgressIndicator: true,
        title: title,
      ).show(context);
    }
  }
}
