import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/menu.dart';
import 'utils/readCommands.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Command to run';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    readCommand();

    MaterialApp coreApp = MaterialApp(
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        home: const StatefulMenu());

    return Container(
      color: Colors.white,
      child: SafeArea(child: coreApp),
    );
  }
}
