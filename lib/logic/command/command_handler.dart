import 'package:flutter/material.dart';

import 'json_handler.dart';

class CommandHandler {
  static Future<String> getCommandDescription(String commandName) async {
    Map<String, dynamic> commandStructure = (await JsonHandler.loadJsonFromFile("assets/json/$commandName.json"))[commandName];

    if (commandStructure.isEmpty) return "";
    if (commandStructure.keys.contains("DESCRIPTION") == false) return "";

    return commandStructure["DESCRIPTION"][0].toString();
  }

  static Future<List> loadCommand(String commandName) async {
    List paragraphs = [];
    List sections = [];

    Map<String, dynamic> commandStructure = (await JsonHandler.loadJsonFromFile("assets/json/$commandName.json"))[commandName];

    for (String section in commandStructure.keys) {
      List<String> paragraph = [];
      for (String sectionParagraph in commandStructure[section]) {
        paragraphs.add(sectionParagraph);
      }
      paragraphs.add(paragraph.join('\n\n'));
      sections.add(section);
    }

    return [commandName, sections, paragraphs];
  }

  static List<Widget> renderCommand(List commandSections, List commandParagraphs, Map<GlobalKey, String> searchUtility) {
    List<Widget> renderBody = [];
    List<Widget> renderChild = [];

    print(commandSections.length);
    print(commandParagraphs.length);

    /// foreach section
    for (int i = 0; i < commandSections.length; i++) {
      for (int j = 0; j < commandParagraphs.length; ++j) {
        renderChild = [];

        /// foreach paragraph in current section
        ///generate key
        GlobalKey paragraphKey = new GlobalKey();

        ///add paragraph to search utility
        // print(commandParagraphs);
        searchUtility[paragraphKey] = commandParagraphs[i];

        renderChild.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            key: paragraphKey,
            child: SelectableText(commandParagraphs[i][j],
                style: const TextStyle(
                  color: Colors.black,
                ))));

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
                        commandSections[i],

                        /// Command Section Name
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      ),
                      ...renderChild
                    ],
                  ),
                ))));
      }
    }
    return renderBody;
  }
}
