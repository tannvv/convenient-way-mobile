import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';

class Product {
  int? price;
  String? name;
  String? description;
  String? packageId;

  Product({this.price, this.name, this.description, this.packageId});

  Product.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    description = json['description'];
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    data['packageId'] = packageId;
    return data;
  }

  CreateProductModel toCreateModel() {
    CreateProductModel model = CreateProductModel();
    model.price = price;
    model.name = name;
    model.description = description;
    return model;
  }
}
