import 'package:trustlinesflutterwithwrapper/models/models.dart';

class Transfer {
  String? networkAddress;
  String? receiverAddress;
  int? value;
  Wallet? wallet;

  Transfer(
      {this.networkAddress, this.receiverAddress, this.value, this.wallet});

  Transfer.fromJson(Map<String, dynamic> json)
      : networkAddress = json['networkAddress'],
        receiverAddress = json['receiverAddress'],
        value = json['value'],
        wallet = json['wallet'];
}
