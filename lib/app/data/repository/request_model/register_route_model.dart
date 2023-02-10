class RegisterRoute {
  String? fromAddress;
  double? fromLongitude;
  double? fromLatitude;
  String? toAddress;
  double? toLongitude;
  double? toLatitude;
  String? accountId;

  RegisterRoute(
      {required this.fromAddress,
      required this.fromLongitude,
      required this.fromLatitude,
      required this.toAddress,
      required this.toLongitude,
      required this.toLatitude,
      required this.accountId});

  RegisterRoute.fromJson(Map<String, dynamic> json) {
    fromAddress = json['fromAddress'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toAddress = json['toAddress'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromAddress'] = fromAddress;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['toAddress'] = toAddress;
    data['toLongitude'] = toLongitude;
    data['toLatitude'] = toLatitude;
    data['accountId'] = accountId;
    return data;
  }
}
