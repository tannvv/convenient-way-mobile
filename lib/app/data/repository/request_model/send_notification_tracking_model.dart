import 'package:tien_duong/app/data/constants/notification_type.dart';

class SendNotificationTrackingModel {
  String? deliverId;
  String? title;
  String? typeOfNotification;
  Map<String, dynamic>? data;

  SendNotificationTrackingModel(
      {this.title,
      this.data,
      this.deliverId,
      this.typeOfNotification = TypeOfNotification.TRACKING});

  SendNotificationTrackingModel.fromJson(Map<String, dynamic> json) {
    deliverId = json['deliverId'];
    typeOfNotification = json['typeOfNotification'];
    title = json['title'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliverId'] = deliverId;
    data['typeOfNotification'] = typeOfNotification;
    data['title'] = title;
    data['data'] = this.data;
    return data;
  }
}
