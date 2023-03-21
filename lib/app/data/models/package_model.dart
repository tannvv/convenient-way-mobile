import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/product_model.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';

class Package {
  String? id;
  String? startAddress;
  double? startLongitude;
  double? startLatitude;
  String? destinationAddress;
  double? destinationLongitude;
  double? destinationLatitude;
  String? pickupName;
  String? pickupPhone;
  String? receiverName;
  String? receiverPhone;
  double? distance;
  double? length;
  double? width;
  double? height;
  double? weight;
  String? status;
  int? priceShip;
  String? photoUrl;
  String? note;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? senderId;
  Account? sender;
  String? deliverId;
  Account? deliver;
  List<Product>? products;
  List<TransactionPackage>? transactionPackages;

  Package(
      {this.id,
      this.startAddress,
      this.startLongitude,
      this.startLatitude,
      this.destinationAddress,
      this.destinationLongitude,
      this.destinationLatitude,
      this.pickupName,
      this.pickupPhone,
      this.receiverName,
      this.receiverPhone,
      this.distance,
      this.length,
      this.width,
      this.height,
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
      this.transactionPackages,
      this.products});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAddress = json['startAddress'];
    startLongitude = json['startLongitude'];
    startLatitude = json['startLatitude'];
    destinationAddress = json['destinationAddress'];
    destinationLongitude = json['destinationLongitude'];
    destinationLatitude = json['destinationLatitude'];
    pickupName = json['pickupName'];
    pickupPhone = json['pickupPhone'];
    receiverName = json['receiverName'];
    receiverPhone = json['receiverPhone'];
    distance = json['distance'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
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
    if (json['packageTransactions'] != null) {
      transactionPackages = <TransactionPackage>[];
      json['packageTransactions'].forEach((v) {
        transactionPackages?.add(TransactionPackage.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['startAddress'] = startAddress;
    data['startLongitude'] = startLongitude;
    data['startLatitude'] = startLatitude;
    data['destinationAddress'] = destinationAddress;
    data['destinationLongitude'] = destinationLongitude;
    data['destinationLatitude'] = destinationLatitude;
    data['pickupName'] = pickupName;
    data['pickupPhone'] = pickupPhone;
    data['receiverName'] = receiverName;
    data['receiverPhone'] = receiverPhone;
    data['distance'] = distance;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['weight'] = weight;
    data['status'] = status;
    data['priceShip'] = priceShip;
    data['photoUrl'] = photoUrl;
    data['note'] = note;
    data['createdAt'] = createdAt;
    data['modifiedAt'] = modifiedAt;
    data['senderId'] = senderId;
    if (sender != null) {
      data['sender'] = sender?.toJson();
    }
    data['deliverId'] = deliverId;
    if (deliver != null) {
      data['deliver'] = deliver?.toJson();
    }
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String getProductNames() {
    String names = '';
    products?.forEach((element) {
      names += '${element.name!}, ';
    });
    if (names.length > 3) {
      names = names.substring(0, names.length - 2);
    }
    return names;
  }

  int getTotalPrice() {
    int total = 0;
    products?.forEach((element) {
      total += element.price!;
    });
    return total;
  }
}
