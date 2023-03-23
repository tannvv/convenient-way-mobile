import 'package:tien_duong/app/core/values/app_values.dart';

class FeedbackListModel {
  String? packageId;
  String? creatorId;
  String? receiverId;
  String? feedbackFor;
  int? pageSize;
  int? pageIndex;

  FeedbackListModel(
      {this.packageId,
      this.creatorId,
      this.receiverId,
      this.feedbackFor,
      this.pageSize = AppValues.defaultPageSize,
      this.pageIndex = AppValues.defaultPageIndex});

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'creatorId': creatorId,
        'receiverId': receiverId,
        'feedbackFor': feedbackFor,
        'pageSize': pageSize,
        'pageIndex': pageIndex
      };
}
