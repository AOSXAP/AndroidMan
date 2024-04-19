import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/logic/build_widget/command_builder.dart';
import 'dart:convert';

import 'package:flutter_application_1/theme/theme_definition.dart';

class Logic{
  static Future<String> getCommandDescription(String command) async {
    /// Description: This function returns the description of a given command
    /// Input: String
    /// Output: Future <String>
    
    String fileName = command;

    /// load command from json file
    final String jsonCommand =
    await rootBundle.loadString("assets/json/$fileName");

    var commandMap = <String, dynamic>{};

    /// decode into map
    if (jsonCommand.isNotEmpty) {
      commandMap = jsonDecode(jsonCommand) as Map<String, dynamic>;
    }
    
    fileName = fileName.replaceAll(".json", "");

    /// if command json file contains description, return it
    if (commandMap[fileName].length != 0) {
      if (commandMap[fileName].keys.contains("DESCRIPTION")) {
        return commandMap[fileName]["DESCRIPTION"][0].toString();
      }
    }
    
    /// return empty string if description not found
    return "";
  }

  static Future<List> loadCommand(String commandName) async {
    /// Description: Returns Name of command, list of paragraphs and list of Sections
    /// Input: String
    /// Output: Future <List> (List of lists)
    
    //https://docs.flutter.dev/ui/assets/assets-and-images#asset-bundling
    
    /// a list containing lists of Strings
    /// each section has a coresponding list of paragraphs
    List loadParagraphs = [[]];
    
    /// a list containing all sections of a command
    List loadSections = [''];

    /// load command from json file
    String fileName = commandName;

    final String jsonCommand =
    await rootBundle.loadString("assets/json/$fileName");

    var commandMap = <String, dynamic>{};

    /// decode file as map
    if (jsonCommand.isNotEmpty) {
      commandMap = jsonDecode(jsonCommand) as Map<String, dynamic>;
    }

    fileName = fileName.replaceAll(".json", "");

    /// section index
    int index = 0;

    /// distribute sections and paragraphs from map to their lists
    if (jsonCommand.isNotEmpty) {
      /// foreach section in map
      for (var sectionName in commandMap[fileName].keys) {
        loadParagraphs.add([]);

        ///foreach paragraph
        for (var sectionParagraph in commandMap[fileName][sectionName]) {
          loadParagraphs[index].add(sectionParagraph.toString());
        }

        /// update section index
        index += 1;
        loadSections.add(sectionName.toString());
      }
    }

    return [fileName, loadSections, loadParagraphs];
  }

  static List<Widget> renderCommand(List commandSections, List commandParagraphs, Map<GlobalKey,String> searchUtility, BuildContext context) {
    /// Description: Renders Command after it's content was loaded
    return BuildCommand.buildWidget(commandSections, commandParagraphs, searchUtility, context);
  }
}