class SelectedPackagesModel {
  String deliverId;
  List<String> packageIds;

  SelectedPackagesModel({
    required this.deliverId,
    required this.packageIds,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['deliverId'] = deliverId;
    data['packageIds'] = packageIds;
    return data;
  }
}
