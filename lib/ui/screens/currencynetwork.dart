import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class CurrencyNetworkPage extends StatefulWidget {
  const CurrencyNetworkPage({Key? key}) : super(key: key);

  @override
  _CurrencyNetworkPageState createState() => _CurrencyNetworkPageState();
}

class _CurrencyNetworkPageState extends State<CurrencyNetworkPage> {
  final ApiBloc apiBloc = ApiBloc();
  List<Network> items = [];

  @override
  void initState() {
    apiBloc.add(ApiGetNetwork());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Networks"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {
          print(state);
          if (state is ApiNetworkData) {
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
          if (state is ApiNetworkData) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Network network = items[index];
                return NetworkTile(
                    title: network.name!, sub: network.abbreviation!);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
