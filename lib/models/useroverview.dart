class UserOverview {
  Balance? balance;
  Balance? frozenBalance;
  Balance? given;
  Balance? leftGiven;
  Balance? leftReceived;
  Balance? received;

  UserOverview(
      {this.balance,
      this.frozenBalance,
      this.given,
      this.leftGiven,
      this.leftReceived,
      this.received});

  UserOverview.fromJson(Map<String, dynamic> json)
      : balance = Balance.fromJson(json['balance']),
        frozenBalance = Balance.fromJson(json['frozenBalance']),
        given = Balance.fromJson(json['given']),
        leftGiven = Balance.fromJson(json['leftGiven']),
        leftReceived = Balance.fromJson(json['leftReceived']),
        received = Balance.fromJson(json['received']);
}

class Balance {
  int? decimals;
  String? raw;
  String? value;

  Balance({this.decimals, this.raw, this.value});

  Balance.fromJson(Map<String, dynamic> json)
      : decimals = json['decimals'],
        raw = json['raw'],
        value = json['value'];
}
