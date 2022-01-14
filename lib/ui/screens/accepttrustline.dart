import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/credit_line.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class AcceptTrustlinePage extends StatefulWidget {
  const AcceptTrustlinePage({Key? key}) : super(key: key);

  @override
  _UpdateTrustlinePageState createState() => _UpdateTrustlinePageState();
}

class _UpdateTrustlinePageState extends State<AcceptTrustlinePage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController givenController = TextEditingController();
  TextEditingController receivedController = TextEditingController();
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
        title: const Text("Accept Trustline"),
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
            showToast("Accepted Trustline");
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
              givenField(),
              receivedField(),
              (state is ApiLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : acceptBtn(),
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

  Widget givenField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        controller: givenController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Given Credit Line",
        ),
      ),
    );
  }

  Widget receivedField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        controller: receivedController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: "Received Credit Line",
        ),
      ),
    );
  }

  Widget acceptBtn() {
    return TileContainer(
      title: "Accept Trustline",
      ontap: () {
        if (currentNetwork!.address != null) {
          if (addressController.text.isNotEmpty &&
              givenController.text.isNotEmpty &&
              receivedController.text.isNotEmpty) {
            CreditLine data = CreditLine(
                networkAddress: currentNetwork!.address,
                contactAddress: addressController.text,
                clgiven: givenController.text,
                clreceived: receivedController.text,
                wallet: wallet);
            apiBloc.add(ApiAcceptTrustline(data: data));
          } else {
            showToast("Please enter address and given or received credit line");
          }
        } else {
          showToast("Please Choose Network");
        }
      },
    );
  }
}
