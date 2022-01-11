import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  _CreateWalletPageState createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final ApiBloc apiBloc = ApiBloc();
  Wallet? wallet = Wallet();

  @override
  Widget build(BuildContext context) {
    String? public = Storage.prefs!.getString(cpublickey);
    String? private = Storage.prefs!.getString(cprivatekey);
    int? version = Storage.prefs!.getInt(cversion);
    String? seed = Storage.prefs!.getString(cseed);
    String? type = Storage.prefs!.getString(ctype);
    SigningKey? keys = SigningKey(mnemonic: seed, privatekey: private);
    wallet = Wallet(address: public, version: version, type: type, keys: keys);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Trustline Wallet"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          print(state);
          if (state is ApiWalletData) {
            setState(() {});
            showToast("Wallet Created");
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (state is ApiLoading)
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: CircularProgressIndicator())
                  : createbtn(),
              () {
                if (wallet!.address != null) {
                  return dataContainer(wallet!);
                }
                return Container();
              }(),
              () {
                if (wallet!.address != null) {
                  return TileContainer(
                    title: "Copy Public Key",
                    ontap: () {
                      FlutterClipboard.copy(wallet!.address!)
                          .then((value) => showToast("Copied Private Key"));
                    },
                  );
                }
                return Container();
              }(),
              () {
                if (wallet!.address != null) {
                  return TileContainer(
                    title: "Copy Private Key",
                    ontap: () {
                      FlutterClipboard.copy(wallet!.keys!.privatekey!)
                          .then((value) => showToast("Copied Private Key"));
                    },
                  );
                }
                return Container();
              }(),
              () {
                if (wallet!.address != null) {
                  return TileContainer(
                    title: "Copy Seed",
                    ontap: () {
                      FlutterClipboard.copy(wallet!.keys!.mnemonic!)
                          .then((value) => showToast("Copied Seed"));
                    },
                  );
                }
                return Container();
              }(),
            ],
          );
        },
      ),
    );
  }

  Widget dataContainer(Wallet data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            centerRow("Address", data.address!),
            centerRow("Version", data.version.toString()),
            centerRow("Type", data.type!),
            centerRow("Mnemonic", data.keys!.mnemonic!),
            centerRow("Private Key", data.keys!.privatekey!),
          ],
        ),
      ),
    );
  }

  Widget centerRow(String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: SelectableText(
                sub,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createbtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () {
          apiBloc.add(ApiCreateWallet());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Create",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
