import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class CurrencyNetworkPage extends StatefulWidget {
  const CurrencyNetworkPage({Key? key}) : super(key: key);

  @override
  _CurrencyNetworkPageState createState() => _CurrencyNetworkPageState();
}

class _CurrencyNetworkPageState extends State<CurrencyNetworkPage> {
  List<Network> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Networks"),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          Network network = items[index];
          return NetworkTile(title: network.name!, sub: network.abbreviation!);
        },
      ),
    );
  }
}
