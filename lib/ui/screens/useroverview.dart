import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({Key? key}) : super(key: key);

  @override
  _UserOverviewPageState createState() => _UserOverviewPageState();
}

class _UserOverviewPageState extends State<UserOverviewPage> {
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
        title: const Text("User Overview"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          // print(state);
          if (state is ApiNetworkData) {
            setState(() {
              networklist = state.data;
            });
          }
          if (state is ApiOverviewData) {
            setState(() {
              dataNetwork = currentNetwork!.name!;
            });
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
              getBtn(),
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              child: Text(dataNetwork!,
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
          Row(
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: Text(
                    "Decimal",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: SelectableText(
                    decimals,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: Text(
                    "Raw",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: SelectableText(
                    raw,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: Text(
                    "Value",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 500,
                  child: SelectableText(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: GestureDetector(
        onTap: () {
          if (currentNetwork!.name != null && wallet!.address != null) {
            apiBloc.add(ApiGetOverview(
              wallet: wallet!,
              network: currentNetwork!,
            ));
          } else {
            showToast("Choose Network or Create Wallet");
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Get",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
