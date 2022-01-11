import 'package:http/http.dart' as http;
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

  static Future getEvents() async {
    String url = Api.events;

    final response = await http.post(Uri.parse(url), headers: globalheader);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error getting response');
    }
    return response.body;
  }
}
