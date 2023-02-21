class IsValidAccountModel {
  String? userName;
  String? phone;

  IsValidAccountModel({
    this.userName,
    this.phone,
  });

  IsValidAccountModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['phone'] = phone?.replaceFirst('+84', '0');
    return data;
  }
}
