import 'package:tien_duong/app/data/models/package_model.dart';

class FeedbackModel {
  String? id;
  String? content;
  double? rating;
  String? feedbackFor;
  String? packageId;
  Package? package;
  String? creatorId;
  String? receiverId;
  String? createdAt;

  FeedbackModel(
      {this.id,
      this.content,
      this.rating,
      this.feedbackFor,
      this.packageId,
      this.creatorId,
      this.receiverId,
      this.package,
      this.createdAt});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    rating = json['rating'];
    feedbackFor = json['feedbackFor'];
    packageId = json['packageId'];
    creatorId = json['creatorId'];
    receiverId = json['receiverId'];
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['rating'] = rating;
    data['feedbackFor'] = feedbackFor;
    data['packageId'] = packageId;
    data['creatorId'] = creatorId;
    data['receiverId'] = receiverId;
    data['createdAt'] = createdAt;
    return data;
  }
}
