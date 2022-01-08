class Network {
  String? abbreviation;
  String? address;
  bool? customInterests;
  int? decimals;
  InterestRate? interestRate;
  int? interestRateDecimals;
  bool? isFrozen;
  String? name;
  int? numUsers;
  bool? preventMediatorInterests;

  Network.fromJson(Map<String, dynamic> json)
      : abbreviation = json['abbreviation'],
        address = json['address'],
        customInterests = json['customInterests'],
        decimals = json['decimals'],
        interestRate = InterestRate.fromJson(json['defaultInterestRate']),
        interestRateDecimals = json['interestRateDecimals'],
        isFrozen = json['isFrozen'],
        name = json['name'],
        numUsers = json['numUsers'],
        preventMediatorInterests = json['preventMediatorInterests'];
}

class InterestRate {
  int? decimals;
  String? raw;
  String? value;

  InterestRate.fromJson(Map<String, dynamic> json)
      : decimals = json['decimals'],
        raw = json['raw'],
        value = json['value'];
}
