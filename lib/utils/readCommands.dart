import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> getAllAvailableCommands() async {
  List<String> availableCommands = [];

  const String fileName = "assets/commands.json";
  final String jsonData = await rootBundle.loadString(fileName);
  var jsonMap = <String, dynamic>{};

  if(jsonData.isEmpty) return availableCommands;

  jsonMap = jsonDecode(jsonData) as Map<String, dynamic>;
  for (String commandName in jsonMap["commands"]) {
    availableCommands.add(commandName);
  }

  return availableCommands;
}