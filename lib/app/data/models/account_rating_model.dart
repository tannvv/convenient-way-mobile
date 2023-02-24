class AccountRating {
  double? averageRatingDeliver;
  int? totalRatingDeliver;
  double? averageRatingSender;
  int? totalRatingSender;

  AccountRating(
      {this.averageRatingDeliver,
      this.totalRatingDeliver,
      this.averageRatingSender,
      this.totalRatingSender});

  AccountRating.fromJson(Map<String, dynamic> json) {
    averageRatingDeliver = json['averageRatingDeliver'] == 'NaN'
        ? 0
        : json['averageRatingDeliver'];
    totalRatingDeliver = json['totalRatingDeliver'];
    averageRatingSender =
        json['averageRatingSender'] == 'NaN' ? 0 : json['averageRatingSender'];
    totalRatingSender = json['totalRatingSender'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['averageRatingDeliver'] = averageRatingDeliver;
    data['totalRatingDeliver'] = totalRatingDeliver;
    data['averageRatingSender'] = averageRatingSender;
    data['totalRatingSender'] = totalRatingSender;
    return data;
  }
}
