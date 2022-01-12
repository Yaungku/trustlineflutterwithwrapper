import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

class GetEventPage extends StatefulWidget {
  const GetEventPage({Key? key}) : super(key: key);

  @override
  _GetEventPageState createState() => _GetEventPageState();
}

class _GetEventPageState extends State<GetEventPage> {
  final ApiBloc apiBloc = ApiBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
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
