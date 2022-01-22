import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class GetEventPage extends StatefulWidget {
  const GetEventPage({Key? key}) : super(key: key);

  @override
  _GetEventPageState createState() => _GetEventPageState();
}

class _GetEventPageState extends State<GetEventPage> {
  final ApiBloc apiBloc = ApiBloc();
  Wallet? wallet;
  List<Event> items = [];

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
    } else {
      apiBloc.add(ApiGetEvents(wallet: wallet!));
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          if (state is ApiEventData) {
            setState(() {
              items = state.data;
            });
          }
        },
        builder: (context, state) {
          if (state is ApiLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ApiFail) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is ApiEventData) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Event event = items[index];
                return eventContainer(event);
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget eventContainer(Event data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CenterRow("Type", data.type!),
            CenterRow("From", data.from!),
            CenterRow("To", data.to!)
          ],
        ),
      ),
    );
  }
}
