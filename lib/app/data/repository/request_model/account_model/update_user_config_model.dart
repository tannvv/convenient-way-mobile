class UpdateUserConfigModel {
  String? accountId;
  String? configName;
  String? configValue;

  UpdateUserConfigModel({this.accountId, this.configName, this.configValue});

  UpdateUserConfigModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    configName = json['configName'];
    configValue = json['configValue'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['configName'] = configName;
    data['configValue'] = configValue;
    return data;
  }
}
