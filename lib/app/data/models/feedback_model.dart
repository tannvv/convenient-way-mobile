class Feedback {
  String? id;
  String? content;
  double? rating;
  String? feedbackFor;
  String? packageId;
  String? creatorId;
  String? receiverId;
  String? createdAt;

  Feedback(
      {this.id,
      this.content,
      this.rating,
      this.feedbackFor,
      this.packageId,
      this.creatorId,
      this.receiverId,
      this.createdAt});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    rating = json['rating'];
    feedbackFor = json['feedbackFor'];
    packageId = json['packageId'];
    creatorId = json['creatorId'];
    receiverId = json['receiverId'];
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
