class UserConfig {
  String? name;
  String? value;
  String? modifiedAt;
  String? infoUserId;

  UserConfig({this.name, this.value, this.modifiedAt, this.infoUserId});

  UserConfig.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    modifiedAt = json['modifiedAt'];
    infoUserId = json['infoUserId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['modifiedAt'] = modifiedAt;
    data['infoUserId'] = infoUserId;
    return data;
  }
}
