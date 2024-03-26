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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "";
  static String changeTitle = "Command";
  static final List _friendsList = [''];

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

      if(jsonString.isNotEmpty) {
        comm  = jsonDecode(jsonString) as Map<String, dynamic>;
      }

      setState(() {
        changeTitle = file_name;
        _friendsList.clear();
        if(js.isNotEmpty){
          for(var key in comm[file_name].keys){
            _friendsList.add(comm[file_name][key].toString());
          }
        }
      });
    }



List<Widget> _getFriends(){
  List<Widget> friendsTextFields = [];
  for(int i=0; i<_friendsList.length; i++){
  friendsTextFields.add(
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
        Text(
          _friendsList[i].toString(),
        )
        ],
      ),
    )
  );
}
return friendsTextFields;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(changeTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ..._getFriends()
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
