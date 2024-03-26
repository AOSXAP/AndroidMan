import 'dart:ffi';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Command to run';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "";
  static String changeTitle = "Command";

  void _incrementCounter() {
    setState((){
      //getJson();
      _listofFiles();
      
    });
  }

  void _listofFiles() async {
      final file = io.Directory("assets/json/").listSync(); 
      String js = "";
      String file_name = "";

      var rng = Random();
      int chosenFile = rng.nextInt(file.length);

      final String jsonString = await rootBundle.loadString(file.elementAt(chosenFile).path);
      js = (jsonString);

      file_name = file.elementAt(chosenFile).path.replaceAll(".json", "");
      file_name = file_name.replaceAll("assets/json/", "");

      Map<String,dynamic> comm =  Map<String,dynamic>();

      if(jsonString != "") {
        comm  = jsonDecode(jsonString) as Map<String, dynamic>;
      }

      setState(() {
        changeTitle = file_name;
        if(js != "")_counter = comm[file_name]['DESCRIPTION'].toString(); 
      });
    }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(changeTitle),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _counter,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
