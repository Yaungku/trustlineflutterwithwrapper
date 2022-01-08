import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/routes.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? publickey;
  @override
  void initState() {
    setState(() {
      publickey = Storage.prefs!.getString(cpublickey)!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trustline with Wrapper"),
      ),
      body: ListView(
        children: [
          (publickey != null) ? publickeyField() : Container(),
          TileContainer(
            title: "Get Events",
            ontap: () {},
          ),
          TileContainer(
            title: "Get Currency Networks",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const CurrencyNetworkPage()));
            },
          ),
          TileContainer(
            title: "Get User Overview of specific currency network",
            ontap: () {},
          ),
          TileContainer(
            title: "Transfer",
            ontap: () {},
          ),
          TileContainer(
            title: "Create Identity Type Trustline Wallet",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const CreateWallet()));
            },
          ),
          TileContainer(
            title: "Recover Wallet data from seed",
            ontap: () {},
          ),
          TileContainer(
            title: "Recover Wallet data from private key",
            ontap: () {},
          ),
          TileContainer(
            title: "Delete Wallet",
            ontap: () {},
          ),
        ],
      ),
    );
  }

  Widget publickeyField() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "Public Key",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SelectableText(
            publickey!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
