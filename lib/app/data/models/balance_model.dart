class BalanceModel {
  bool? isNewAccount;
  int? balance;

  BalanceModel({this.isNewAccount, this.balance});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    isNewAccount = json['isNewAccount'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isNewAccount'] = isNewAccount;
    data['balance'] = balance;
    return data;
  }
}
