import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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

  static List<Widget> renderCommand(List commandSections, List commandParagraphs, Map<GlobalKey,String> searchUtility) {
    /// Description: Renders Command after it's content was loaded
    /// Input: List,List,Map<GlobalKey,String>
    /// Output: List<Widget>

    /// Widget Body
    List<Widget> renderBody = [];

    /// child of Widget,stores paragraphs
    List<Widget> renderChild = [];

    /// foreach section
    for (int i = 0; i < commandSections.length - 1; i++) {
      renderChild = [];
      /// foreach paragraph in current section
      for (int j = 0; j < commandParagraphs[i].length; j++) {
        ///generate key
        GlobalKey paragraphKey =  new GlobalKey();

        ///add paragraph to search utility
        searchUtility[paragraphKey] = commandParagraphs[i][j];

        renderChild.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            key: paragraphKey,
            child: SelectableText(commandParagraphs[i][j],
                style: const TextStyle(
                  color: Colors.black,
                ))));
      }

      /// build render Widget
      renderBody.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commandSections[i + 1], /// Command Section Name
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    ...renderChild
                  ],
                ),
              ))));
    }
    return renderBody;
  }
}