import 'package:flutter/material.dart';
import 'package:trustlinesflutterwithwrapper/bloc/api/api_bloc.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/home.dart';
import 'package:trustlinesflutterwithwrapper/ui/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: BlocProvider(
        create: (context) => ApiBloc(),
        child: MaterialApp(
          title: 'Trustline With JS Wrapper',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
