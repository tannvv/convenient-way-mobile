import 'package:tien_duong/app/core/values/app_values.dart';

class FeedbackListModel {
  String? packageId;
  String? accountId;
  String? feedbackFor;
  int? pageSize;
  int? pageIndex;

  FeedbackListModel(
      {this.packageId,
      this.accountId,
      this.feedbackFor,
      this.pageSize = AppValues.defaultPageSize,
      this.pageIndex = AppValues.defaultPageIndex});

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'accountId': accountId,
        'feedbackFor': feedbackFor,
        'pageSize': pageSize,
        'pageIndex': pageIndex
      };
}
