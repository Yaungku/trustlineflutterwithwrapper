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
  void deleteDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure to delete?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Storage.prefs!.remove(cpublickey);
              Storage.prefs!.remove(cprivatekey);
              Storage.prefs!.remove(cseed);
              Storage.prefs!.remove(ctype);
              Storage.prefs!.remove(cversion);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? key = Storage.prefs!.getString(cpublickey);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trustline with Wrapper"),
      ),
      body: ListView(
        children: [
          (key != null) ? publickeyField(key) : Container(),
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
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const UserOverviewPage()));
            },
          ),
          TileContainer(
            title: "Transfer",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const TransferPage()));
            },
          ),
          TileContainer(
            title: "Create Identity Type Trustline Wallet",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const CreateWalletPage()));
            },
          ),
          TileContainer(
            title: "Recover Wallet data from seed",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const RecoverFromSeedPage()));
            },
          ),
          TileContainer(
            title: "Recover Wallet data from private key",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const RecoverFromPrivateKeyPage()));
            },
          ),
          TileContainer(
            title: "Delete Wallet",
            ontap: () {
              deleteDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget publickeyField(String key) {
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
            key,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
