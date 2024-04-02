import 'package:flutter/material.dart';
import 'package:flutter_application_1/menu.dart';
import 'command.dart';
import 'utils/readCommands.dart';
import 'package:getwidget/getwidget.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Command to run';
  // This widget is the root of your application.
  @override 
  Widget build(BuildContext context) {
    readCommand();
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 42, 42, 42),
      ),
      home: const StatefulMenu()
    );
  }
}
