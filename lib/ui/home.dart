import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/ui/routes.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trustline with Wrapper"),
      ),
      body: ListView(
        children: [
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
            ontap: () {},
          ),
          TileContainer(
            title: "Recover Wallet data from seed",
            ontap: () {},
          ),
          TileContainer(
            title: "Recover Wallet data from private key",
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
