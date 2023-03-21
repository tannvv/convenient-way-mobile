class TransactionPackage {
  String? fromStatus;
  String? toStatus;
  String? description;
  String? reason;
  String? imageUrl;
  DateTime? createdAt;
  String? packageId;

  TransactionPackage(
      {this.fromStatus,
      this.toStatus,
      this.description,
      this.reason,
      this.imageUrl,
      this.createdAt,
      this.packageId});

  TransactionPackage.fromJson(Map<String, dynamic> json) {
    fromStatus = json['fromStatus'];
    toStatus = json['toStatus'];
    description = json['description'];
    reason = json['reason'];
    imageUrl = json['imageUrl'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromStatus'] = fromStatus;
    data['toStatus'] = toStatus;
    data['description'] = description;
    data['reason'] = reason;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['packageId'] = packageId;
    return data;
  }
}
