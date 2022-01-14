import 'package:trustlinesflutterwithwrapper/models/models.dart';

class CreditLine {
  String? networkAddress;
  String? contactAddress;
  String? clgiven;
  String? clreceived;
  Wallet? wallet;

  CreditLine(
      {this.networkAddress,
      this.contactAddress,
      this.clgiven,
      this.clreceived,
      this.wallet});

  CreditLine.fromJson(Map<String, dynamic> json)
      : networkAddress = json['networkAddress'],
        contactAddress = json['contactAddress'],
        clgiven = json['clGiven'],
        clreceived = json['clReceived'],
        wallet = json['wallet'];
}
