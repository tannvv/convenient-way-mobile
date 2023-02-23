import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/product_model.dart';

class PackageCancelListModel {
  String? reason;
  String? cancelTime;
  String? id;
  String? startAddress;
  double? startLongitude;
  double? startLatitude;
  String? destinationAddress;
  double? destinationLongitude;
  double? destinationLatitude;
  String? receiverName;
  String? receiverPhone;
  double? distance;
  double? volume;
  double? weight;
  String? status;
  int? priceShip;
  String? photoUrl;
  String? note;
  String? createdAt;
  String? modifiedAt;
  String? senderId;
  String? sender;
  String? deliverId;
  Account? deliver;
  List<Product>? products;

  PackageCancelListModel(
      {this.reason,
        this.cancelTime,
        this.id,
        this.startAddress,
        this.startLongitude,
        this.startLatitude,
        this.destinationAddress,
        this.destinationLongitude,
        this.destinationLatitude,
        this.receiverName,
        this.receiverPhone,
        this.distance,
        this.volume,
        this.weight,
        this.status,
        this.priceShip,
        this.photoUrl,
        this.note,
        this.createdAt,
        this.modifiedAt,
        this.senderId,
        this.sender,
        this.deliverId,
        this.deliver,
        this.products});

  PackageCancelListModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    cancelTime = json['cancelTime'];
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
    volume = json['volume'];
    weight = json['weight'];
    status = json['status'];
    priceShip = json['priceShip'];
    photoUrl = json['photoUrl'];
    note = json['note'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    senderId = json['senderId'];
    sender = json['sender'];
    deliverId = json['deliverId'];
    deliver =
    json['deliver'] != null ? new Account.fromJson(json['deliver']) : null;
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['cancelTime'] = this.cancelTime;
    data['id'] = this.id;
    data['startAddress'] = this.startAddress;
    data['startLongitude'] = this.startLongitude;
    data['startLatitude'] = this.startLatitude;
    data['destinationAddress'] = this.destinationAddress;
    data['destinationLongitude'] = this.destinationLongitude;
    data['destinationLatitude'] = this.destinationLatitude;
    data['receiverName'] = this.receiverName;
    data['receiverPhone'] = this.receiverPhone;
    data['distance'] = this.distance;
    data['volume'] = this.volume;
    data['weight'] = this.weight;
    data['status'] = this.status;
    data['priceShip'] = this.priceShip;
    data['photoUrl'] = this.photoUrl;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['senderId'] = this.senderId;
    data['sender'] = this.sender;
    data['deliverId'] = this.deliverId;
    if (this.deliver != null) {
      data['deliver'] = this.deliver!.toJson();
    }
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
