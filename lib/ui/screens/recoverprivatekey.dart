import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class RecoverFromPrivateKeyPage extends StatefulWidget {
  const RecoverFromPrivateKeyPage({Key? key}) : super(key: key);

  @override
  _RecoverFromPrivateKeyPageState createState() =>
      _RecoverFromPrivateKeyPageState();
}

class _RecoverFromPrivateKeyPageState extends State<RecoverFromPrivateKeyPage> {
  final ApiBloc apiBloc = ApiBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Networks"),
      ),
      body: BlocConsumer<ApiBloc, ApiState>(
        bloc: apiBloc,
        listener: (context, state) {},
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

          return Container();
        },
      ),
    );
  }
}
