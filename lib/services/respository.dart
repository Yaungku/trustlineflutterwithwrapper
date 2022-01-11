import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/api.dart';

class Respository {
  static Future createWallet() async {
    String url = Api.createwallet;

    final response = await http.get(Uri.parse(url), headers: globalheader);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error getting response');
    }
    return response.body;
  }

  static Future getnetworks() async {
    String url = Api.currencynetworks;

    final response = await http.get(Uri.parse(url), headers: globalheader);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error getting response');
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
      throw Exception('Error getting response');
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
      throw Exception('Error getting response');
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
      throw Exception('Error getting response');
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
      throw Exception('Error getting response');
    }
    return response.body;
  }
}
