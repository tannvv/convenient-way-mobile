class UpdateLocationModel {
  String? accountId;
  double? latitude;
  double? longitude;

  UpdateLocationModel({this.accountId, this.latitude, this.longitude});

  UpdateLocationModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
