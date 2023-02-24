class PackageCancelListModel {
  String? senderId;
  String? status;
  int? pageIndex;
  int? pageSize;

  PackageCancelListModel(
      {this.deliverId,
      this.senderId,
      this.status,
      this.pageIndex = AppValues.defaultPageIndex,
      this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() => {
        'deliverId': deliverId,
        'senderId': senderId,
        'status': status,
        'pageIndex': pageIndex,
        'pageSize': pageSize
      };
}
