class Wallet {
  String? address;
  int? version;
  String? type;
  SigningKey? keys;

  Wallet({this.address, this.version, this.type, this.keys});

  Wallet.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        version = json['version'],
        type = json['type'],
        keys = SigningKey.fromJson(json['meta']['signingKey']);
}

class SigningKey {
  String? mnemonic;
  String? privatekey;

  SigningKey({this.mnemonic, this.privatekey});

  SigningKey.fromJson(Map<String, dynamic> json)
      : mnemonic = json['mnemonic'],
        privatekey = json['privateKey'];
}
