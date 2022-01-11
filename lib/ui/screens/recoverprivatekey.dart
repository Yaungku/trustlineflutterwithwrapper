import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class RecoverFromPrivateKeyPage extends StatefulWidget {
  const RecoverFromPrivateKeyPage({Key? key}) : super(key: key);

  @override
  _RecoverFromPrivateKeyPageState createState() =>
      _RecoverFromPrivateKeyPageState();
}

class _RecoverFromPrivateKeyPageState extends State<RecoverFromPrivateKeyPage> {
  TextEditingController privatekeyController = TextEditingController();
  final ApiBloc apiBloc = ApiBloc();

  void saveDialog(Wallet data) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:
            const Text('Are you sure to save? This will override your wallet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Storage.prefs!.setString(cpublickey, data.address!);
              Storage.prefs!.setString(cprivatekey, data.keys!.privatekey!);
              Storage.prefs!.setString(cseed, data.keys!.mnemonic ?? "");
              Storage.prefs!.setString(ctype, data.type!);
              Storage.prefs!.setInt(cversion, data.version!);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text(
              "Save",
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recover From Private Key"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          if (state is ApiFail) {
            showToast(state.error);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              privateKeyField(),
              (state is ApiLoading)
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: CircularProgressIndicator())
                  : recoverbtn(),
              (state is ApiWalletData)
                  ? dataContainer(state.data)
                  : Container(),
              (state is ApiWalletData)
                  ? TileContainer(
                      title: "Save In Device",
                      ontap: () {
                        saveDialog(state.data);
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget privateKeyField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        controller: privatekeyController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Enter Private Key",
        ),
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
            CenterRow("Address", data.address!),
            CenterRow("Version", data.version.toString()),
            CenterRow("Type", data.type!),
            CenterRow("Mnemonic", data.keys!.mnemonic ?? ""),
            CenterRow("Private Key", data.keys!.privatekey!),
          ],
        ),
      ),
    );
  }

  Widget recoverbtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: GestureDetector(
        onTap: () {
          if (privatekeyController.text != "") {
            apiBloc.add(ApiRecoverFromPrivateKey(
                privateKey: privatekeyController.text));
          } else {
            showToast("Enter Field");
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Recover",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
