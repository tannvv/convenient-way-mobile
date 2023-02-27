import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/product_model.dart';

class PackageCancel extends Package {
  String? reason;
  DateTime? cancelTime;

  PackageCancel(
      {this.reason,
      this.cancelTime,
      id,
      startAddress,
      startLongitude,
      startLatitude,
      destinationAddress,
      destinationLongitude,
      destinationLatitude,
      receiverName,
      receiverPhone,
      distance,
      length,
      width,
      height,
      weight,
      status,
      priceShip,
      photoUrl,
      note,
      createdAt,
      modifiedAt,
      senderId,
      sender,
      deliverId,
      deliver,
      products});

  PackageCancel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    cancelTime = json['cancelTime'] != null
        ? DateTimeUtils.convertStringTimeZoneVN(json['cancelTime'])
        : null;
    id = json['id'];
    startAddress = json['startAddress'];
    startLongitude = json['startLongitude'];
    startLatitude = json['startLatitude'];
    destinationAddress = json['destinationAddress'];
    destinationLongitude = json['destinationLongitude'];
    destinationLatitude = json['destinationLatitude'];
    receiverName = json['receiverName'];
    receiverPhone = json['receiverPhone'];
    distance = json['distance'];
    width = json['width'];
    height = json['height'];
    length = json['length'];
    weight = json['weight'];
    status = json['status'];
    priceShip = json['priceShip'];
    photoUrl = json['photoUrl'];
    note = json['note'];
    createdAt = json['createdAt'] != null
        ? DateTimeUtils.convertStringTimeZoneVN(json['createdAt'])
        : null;
    modifiedAt = json['modifiedAt'] != null
        ? DateTimeUtils.convertStringTimeZoneVN(json['modifiedAt'])
        : null;
    senderId = json['senderId'];
    sender = json['sender'] != null ? Account.fromJson(json['sender']) : null;
    deliverId = json['deliverId'];
    deliver =
        json['deliver'] != null ? Account.fromJson(json['deliver']) : null;
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reason'] = reason;
    data['cancelTime'] = cancelTime;
    super.toJson().forEach((key, value) {
      data[key] = value;
    });
    return data;
  }
}
