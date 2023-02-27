class LogoutModel {
  String? accountId;
  LogoutModel({this.accountId});
  LogoutModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    return data;
  }
}
