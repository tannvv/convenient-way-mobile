import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';

class CreatePackageModel {
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
  int? priceShip;
  String? photoUrl;
  String? note;
  String? senderId;
  List<CreateProductModel>? products;

  CreatePackageModel(
      {this.startAddress,
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
      this.priceShip,
      this.photoUrl,
      this.note,
      this.senderId,
      this.products});

  CreatePackageModel.fromJson(Map<String, dynamic> json) {
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
    priceShip = json['priceShip'];
    photoUrl = json['photoUrl'];
    note = json['note'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['startAddress'] = startAddress;
    data['startLongitude'] = startLongitude;
    data['startLatitude'] = startLatitude;
    data['destinationAddress'] = destinationAddress;
    data['destinationLongitude'] = destinationLongitude;
    data['destinationLatitude'] = destinationLatitude;
    data['receiverName'] = receiverName;
    data['receiverPhone'] = receiverPhone;
    data['distance'] = distance;
    data['volume'] = volume;
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
