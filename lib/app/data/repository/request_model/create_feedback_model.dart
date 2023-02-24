class CreateFeedbackModel {
  String? content;
  String? feedbackFor;
  String? packageId;
  String? accountId;
  double? rating;

  CreateFeedbackModel(
      {this.content,
      this.feedbackFor,
      this.packageId,
      this.accountId,
      this.rating});

  CreateFeedbackModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    feedbackFor = json['feedbackFor'];
    packageId = json['packageId'];
    accountId = json['accountId'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['feedbackFor'] = feedbackFor;
    data['packageId'] = packageId;
    data['accountId'] = accountId;
    data['rating'] = rating;
    return data;
  }
}
