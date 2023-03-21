class CreateFeedbackModel {
  String? content;
  String? feedbackFor;
  String? packageId;
  String? creatorId;
  String? receiverId;
  double? rating;

  CreateFeedbackModel(
      {this.content,
      this.feedbackFor,
      this.packageId,
      this.creatorId,
      this.receiverId,
      this.rating});

  CreateFeedbackModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    feedbackFor = json['feedbackFor'];
    packageId = json['packageId'];
    creatorId = json['creatorId'];
    receiverId = json['receiverId'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['feedbackFor'] = feedbackFor;
    data['packageId'] = packageId;
    data['creatorId'] = creatorId;
    data['receiverId'] = receiverId;
    data['rating'] = rating;
    return data;
  }
}
