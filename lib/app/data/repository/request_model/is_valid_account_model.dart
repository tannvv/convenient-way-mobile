import 'package:tien_duong/app/data/constants/role_name.dart';

class IsValidAccountModel {
  String? userName;
  String? phone;
  String? role;

  IsValidAccountModel({
    this.userName,
    this.phone,
    this.role = RoleName.deliver,
  });

  IsValidAccountModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['phone'] = phone?.replaceFirst('+84', '0');
    data['role'] = role;
    return data;
  }
}
