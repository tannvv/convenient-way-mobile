class DeliveredPackageFailedModel {
  String? packageId;
  String? reason;
  String? imageUrl;

  DeliveredPackageFailedModel({this.packageId, this.reason, this.imageUrl});

  DeliveredPackageFailedModel.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    reason = json['reason'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageId'] = packageId;
    data['reason'] = reason;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
