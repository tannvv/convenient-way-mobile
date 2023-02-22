import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:uuid/uuid.dart';

class CancelModel {
  String? deliverId;
  int? pageIndex;
  int? pageSize;

  CancelModel(
      {this.deliverId = Uuid.NAMESPACE_NIL,
        this.pageIndex = AppValues.defaultPageIndex,
        this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['deliverId'] = deliverId;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}