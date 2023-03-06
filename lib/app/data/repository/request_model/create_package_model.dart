import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';

class CreatePackageModel {
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
  int? priceShip;
  String? photoUrl;
  String? note;
  String? senderId;
  List<CreateProductModel>? products;

  CreatePackageModel(
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
      this.priceShip,
      this.photoUrl,
      this.note,
      this.senderId,
      this.products});

  CreatePackageModel.fromJson(Map<String, dynamic> json) {
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
    priceShip = json['priceShip'];
    photoUrl = json['photoUrl'];
    note = json['note'];
    senderId = json['senderId'];
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
    data['priceShip'] = priceShip;
    data['photoUrl'] = photoUrl;
    data['note'] = note;
    data['senderId'] = senderId;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
