import 'package:tien_duong/app/data/models/account_model.dart';

class UpdateAccount {
  String? accountId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? photoUrl;
  String? gender;

  UpdateAccount(
      {this.accountId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.photoUrl,
      this.gender});

  UpdateAccount.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    gender = json['gender'];
  }

  UpdateAccount.fromAccount(Account account) {
    accountId = account.id;
    firstName = account.infoUser?.firstName;
    lastName = account.infoUser?.lastName;
    email = account.infoUser?.email;
    phone = account.infoUser?.phone;
    photoUrl = account.infoUser?.photoUrl;
    gender = account.infoUser?.gender;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['photoUrl'] = photoUrl;
    data['gender'] = gender;
    return data;
  }
}
