import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List> readCommand() async {
  //https://docs.flutter.dev/ui/assets/assets-and-images#asset-bundling
  List commandsFinalList = [];

  const String fileName = "assets/commands.json";

  final String jsonFileCommands = await rootBundle.loadString(fileName);

  var jsonMap = <String, dynamic>{};

  if (jsonFileCommands.isNotEmpty) {
    jsonMap = jsonDecode(jsonFileCommands) as Map<String, dynamic>;
  }

  if (jsonFileCommands.isNotEmpty) {
      for (var para in jsonMap["commands"]) {
        commandsFinalList.add(para);
      }
  }

  return commandsFinalList;
}