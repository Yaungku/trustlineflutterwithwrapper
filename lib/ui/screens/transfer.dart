import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final ApiBloc apiBloc = ApiBloc();
  Wallet? wallet;
  List<Network> networklist = [];
  Network? currentNetwork;
  String? dataNetwork;

  @override
  void initState() {
    String? public = Storage.prefs!.getString(cpublickey);
    String? private = Storage.prefs!.getString(cprivatekey);
    int? version = Storage.prefs!.getInt(cversion);
    String? seed = Storage.prefs!.getString(cseed);
    String? type = Storage.prefs!.getString(ctype);
    SigningKey? keys = SigningKey(mnemonic: seed, privatekey: private);
    wallet = Wallet(address: public, version: version, type: type, keys: keys);
    if (wallet!.address == null) {
      showToast("Please Create Wallet");
    }
    apiBloc.add(ApiGetNetwork());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          print(state);
          if (state is ApiNetworkData) {
            setState(() {
              networklist = state.data;
            });
          }
          if (state is ApiSuccess) {
            showToast("Sent");
          }
        },
        builder: (context, state) {
          if (state is ApiFail) {
            return Center(
              child: Text(state.error),
            );
          }
          return ListView(
            children: [
              networkList(),
              addressField(),
              valueField(),
              (state is ApiLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : transferBtn(),
              (state is ApiOverviewData)
                  ? overviewContainer(state.data)
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget networkList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          // prefixIcon: const Icon(CupertinoIcons.person_2),
          fillColor: Colors.white,
        ),
        hint: const Text("Choose Network"),
        onChanged: (Network? newValue) {
          setState(() {
            currentNetwork = newValue;
            apiBloc
                .add(ApiGetOverview(wallet: wallet!, network: currentNetwork!));
          });
        },
        items: networklist.map((item) {
          return DropdownMenuItem<Network>(
            child: Text(item.name!),
            value: item,
          );
        }).toList(),
      ),
    );
  }

  Widget addressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        controller: addressController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Enter Address",
        ),
      ),
    );
  }

  Widget valueField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        controller: valueController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Enter Value",
        ),
      ),
    );
  }

  Widget transferBtn() {
    return TileContainer(
      title: "Transfer",
      ontap: () {
        if (currentNetwork!.address != null) {
          if (addressController.text.isNotEmpty &&
              valueController.text.isNotEmpty) {
            Transfer data = Transfer(
                networkAddress: currentNetwork!.address,
                receiverAddress: addressController.text,
                value: int.parse(valueController.text),
                wallet: wallet);
            apiBloc.add(ApiTransfer(data: data));
          } else {
            showToast("Please enter address or value");
          }
        } else {
          showToast("Please Choose Network");
        }
      },
    );
  }

  Widget overviewContainer(UserOverview data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(currentNetwork!.name!,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold)),
            ),
            balanceContainer("Balance", data.balance!.decimals.toString(),
                data.balance!.raw!, data.balance!.value!),
            balanceContainer(
                "Frozen Balance",
                data.frozenBalance!.decimals.toString(),
                data.frozenBalance!.raw!,
                data.frozenBalance!.value!),
            balanceContainer("Given", data.given!.decimals.toString(),
                data.given!.raw!, data.given!.value!),
            balanceContainer("Left Given", data.leftGiven!.decimals.toString(),
                data.leftGiven!.raw!, data.leftGiven!.value!),
            balanceContainer(
                "Left Received",
                data.leftReceived!.decimals.toString(),
                data.leftReceived!.raw!,
                data.leftReceived!.value!),
            balanceContainer("Received", data.received!.decimals.toString(),
                data.received!.raw!, data.received!.value!),
          ],
        ),
      ),
    );
  }

  Widget balanceContainer(
    String title,
    String decimals,
    String raw,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          CenterRow("Decimal", decimals),
          CenterRow("Raw", raw),
          CenterRow("Value", value),
        ],
      ),
    );
  }
}
