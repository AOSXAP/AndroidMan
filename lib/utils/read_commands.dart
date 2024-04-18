import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List> readCommand() async {
  // https://docs.flutter.dev/ui/assets/assets-and-images#asset-bundling

  /// will store all commands names after reading the info from a file
  List allCommands = [];

  /// read all stored commands(~300) from json file
  const String fileName = "assets/commands.json";

  final String jsonFileCommands = await rootBundle.loadString(fileName);

  var jsonMap = <String, dynamic>{};

  /// decode json file and store in map
  if (jsonFileCommands.isNotEmpty) {
    jsonMap = jsonDecode(jsonFileCommands) as Map<String, dynamic>;
  }

  /// adds each command to the initial/return list
  if (jsonFileCommands.isNotEmpty) {
      for (var commandName in jsonMap["commands"]) {
        allCommands.add(commandName);
      }
  }

  return allCommands;
}