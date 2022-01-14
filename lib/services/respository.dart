import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trustlinesflutterwithwrapper/models/credit_line.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/api.dart';

class Respository {
  static Future createWallet() async {
    String url = Api.createwallet;

    final response = await http.get(Uri.parse(url), headers: globalheader);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future getnetworks() async {
    String url = Api.currencynetworks;

    final response = await http.get(Uri.parse(url), headers: globalheader);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future getEvents(Wallet wallet) async {
    String url = Api.events;

    var body = jsonEncode(
      {
        "address": wallet.address,
        "version": wallet.version,
        "type": wallet.type,
        "meta": {
          "signingKey": {
            "mnemonic": wallet.keys!.mnemonic,
            "privateKey": wallet.keys!.privatekey,
          }
        }
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future getuserOverview(Wallet wallet, Network network) async {
    String url = Api.useroverview;

    var body = jsonEncode(
      {
        "networkAddress": network.address,
        "userAddress": wallet.address,
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future recoverFromseed(String seed) async {
    String url = Api.recoverfromseed;

    var body = jsonEncode(
      {
        "seed": seed,
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future recoverFromPrivateKey(String privateKey) async {
    String url = Api.recoverfromprivatekey;

    var body = jsonEncode(
      {
        "key": privateKey,
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future transfer(Transfer data) async {
    String url = Api.transfer;

    var body = jsonEncode(
      {
        "networkAddress": data.networkAddress,
        "receiverAddress": data.receiverAddress,
        "value": data.value,
        "wallet": {
          "address": data.wallet!.address,
          "version": data.wallet!.version,
          "type": data.wallet!.type,
          "meta": {
            "signingKey": {
              "mnemonic": data.wallet!.keys!.mnemonic,
              "privateKey": data.wallet!.keys!.privatekey,
            }
          }
        }
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future updateTrustline(CreditLine data) async {
    String url = Api.updatetrustline;

    var body = jsonEncode(
      {
        "networkAddress": data.networkAddress,
        "contactAddress": data.contactAddress,
        "clGiven": data.clgiven,
        "clReceived": data.clreceived,
        "wallet": {
          "address": data.wallet!.address,
          "version": data.wallet!.version,
          "type": data.wallet!.type,
          "meta": {
            "signingKey": {
              "mnemonic": data.wallet!.keys!.mnemonic,
              "privateKey": data.wallet!.keys!.privatekey,
            }
          }
        }
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }

  static Future acceptTrustline(CreditLine data) async {
    String url = Api.accepttrustline;

    var body = jsonEncode(
      {
        "networkAddress": data.networkAddress,
        "contactAddress": data.contactAddress,
        "clGiven": data.clgiven,
        "clReceived": data.clreceived,
        "wallet": {
          "address": data.wallet!.address,
          "version": data.wallet!.version,
          "type": data.wallet!.type,
          "meta": {
            "signingKey": {
              "mnemonic": data.wallet!.keys!.mnemonic,
              "privateKey": data.wallet!.keys!.privatekey,
            }
          }
        }
      },
    );

    final response =
        await http.post(Uri.parse(url), headers: globalheader, body: body);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }
}
