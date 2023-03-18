import 'package:tien_duong/app/data/constants/role_name.dart';

class LoginModel {
  String? userName;
  String? password;
  String? registrationToken;
  String? role;

  LoginModel(
      {this.userName,
      this.password,
      this.registrationToken,
      this.role = RoleName.deliver});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    registrationToken = json['registrationToken'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['registrationToken'] = registrationToken;
    data['role'] = role;
    return data;
  }
}
