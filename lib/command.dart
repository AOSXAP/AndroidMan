import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Command extends StatefulWidget{
  //default command
  String comm = "ls";

  Command(String commandName){
    comm = commandName;
  }

  @override
  State<Command> createState() => CommandPage(comm);
}

class CommandPage extends State<Command> {
  static String pageTitle = "Command";

  List _commandParagraphs = [[]]; //array of file paragraphs
  List _commandSections = ['']; //array of file sections
  static int index = 0;

  @override

  CommandPage(String commandName){
    _loadCommand(commandName);
  }

  void _loadCommand(String commandName) async {
    //https://docs.flutter.dev/ui/assets/assets-and-images#asset-bundling
    List loadParagraphs = [[]]; 
    List loadSections = ['']; 

    String fileName = commandName;

    final String jsonCommand =
        await rootBundle.loadString("assets/json/$fileName.json");

    var comm = <String, dynamic>{};

    if (jsonCommand.isNotEmpty) {
      comm = jsonDecode(jsonCommand) as Map<String, dynamic>;
    }

      pageTitle = fileName;
      index = 0;

      if (jsonCommand.isNotEmpty) {
        for (var key in comm[fileName].keys) {
          loadParagraphs.add([]);
          for (var para in comm[fileName][key]) {
            loadParagraphs[index].add(para.toString());
          }
          index += 1;
          loadSections.add(key.toString());
        }
      }

      //best way to update when using async/await 
      setState(() {
        _commandParagraphs = loadParagraphs;
        _commandSections = loadSections;
      });
  }

  List<Widget> _renderCommand() {
    List<Widget> commandSectionsBody = [];
    List<Widget> commandParagraphs = [];

    //for every section
    for (int i = 0; i < _commandSections.length - 1; i++) {
      commandParagraphs = [];
      //for each paragraph in current section
      for (int j = 0; j < _commandParagraphs[i].length; j++) {
        commandParagraphs.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Text(_commandParagraphs[i][j],
                style: const TextStyle(
                  color: Colors.white,
                ))));
      }
      //display section and paragraphs
      commandSectionsBody.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Container(
              //color: Color.fromARGB(255, 56, 56, 56),f
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _commandSections[i+1],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    ...commandParagraphs
                  ],
                ),
              ))));
    }
    return commandSectionsBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[..._renderCommand()],
        ),
      ),
    );
  }
}
