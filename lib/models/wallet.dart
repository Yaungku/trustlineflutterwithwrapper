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

  Map<String, dynamic> toJson() => {
        'address': address,
        'version': version,
        'type': type,
        'meta' 'signingKey': keys,
      };
}

class SigningKey {
  String? mnemonic;
  String? privatekey;

  SigningKey({this.mnemonic, this.privatekey});

  SigningKey.fromJson(Map<String, dynamic> json)
      : mnemonic = json['mnemonic'],
        privatekey = json['privateKey'];

  Map<String, dynamic> toJson() => {
        'mnemonic': mnemonic,
        'privateKey': privatekey,
      };
}
