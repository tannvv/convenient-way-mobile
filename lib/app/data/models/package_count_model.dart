class PackageCount {
  int? all;
  int? waiting;
  int? approved;
  int? reject;
  int? selected;
  int? pickupSuccess;
  int? pickupFailed;
  int? deliveredSuccess;
  int? deliveredFailed;
  int? success;
  int? refundToWarehouseSuccess;
  int? refundToWarehouseFailed;
  int? deliverCancel;
  int? senderCancel;
  int? expired;

  PackageCount(
      {this.all,
      this.waiting,
      this.approved,
      this.reject,
      this.selected,
      this.pickupSuccess,
      this.pickupFailed,
      this.deliveredSuccess,
      this.deliveredFailed,
      this.success,
      this.refundToWarehouseSuccess,
      this.refundToWarehouseFailed,
      this.deliverCancel,
      this.senderCancel,
      this.expired});

  PackageCount.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    waiting = json['waiting'];
    approved = json['approved'];
    reject = json['reject'];
    selected = json['selected'];
    pickupSuccess = json['pickupSuccess'];
    pickupFailed = json['pickupFailed'];
    deliveredSuccess = json['deliveredSuccess'];
    deliveredFailed = json['deliveredFailed'];
    success = json['success'];
    refundToWarehouseSuccess = json['refundToWarehouseSuccess'];
    refundToWarehouseFailed = json['refundToWarehouseFailed'];
    deliverCancel = json['deliverCancel'];
    senderCancel = json['senderCancel'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    data['waiting'] = waiting;
    data['approved'] = approved;
    data['reject'] = reject;
    data['selected'] = selected;
    data['pickupSuccess'] = pickupSuccess;
    data['pickupFailed'] = pickupFailed;
    data['deliveredSuccess'] = deliveredSuccess;
    data['deliveredFailed'] = deliveredFailed;
    data['success'] = success;
    data['refundToWarehouseSuccess'] = refundToWarehouseSuccess;
    data['refundToWarehouseFailed'] = refundToWarehouseFailed;
    data['deliverCancel'] = deliverCancel;
    data['senderCancel'] = senderCancel;
    data['expired'] = expired;
    return data;
  }
}
