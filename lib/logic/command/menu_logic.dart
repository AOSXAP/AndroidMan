import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../screens/command/command.dart';

class Logic {

  static List<Widget> getMatchedCommands(Map<String, Widget> commandWidgetMap, String searchedTerm) {
    return commandWidgetMap.entries
        .where((e)=>e.key.contains(searchedTerm))
        .map((e)=>e.value)
        .toList();
  }

  static List<String> _removeExtensionFromFileName(List<String> commands, String extension) {
    return commands.map((command) => command.replaceAll(extension,''))
        .toList();
  }

  static String _shortenDescription(String description) {
    if (description.length < 200) return description;
    return '${description.substring(0, 196)} ...';
  }

  static Future<Map<String, Widget>> loadCommandsFromMemory(
      BuildContext context, List<String> commandList) async {
    Map<String, Widget> commandWidgetMap = {};
    commandList = _removeExtensionFromFileName(["random", ...commandList], ".json");

    for (String commandName in commandList) {
      Command command = Command(commandName);
      String description = "random command";

      if (commandName != "random") {
        description = await Command.listDescription(commandName);
      }

      description = _shortenDescription(description);
      commandWidgetMap.addAll({
        commandName: CommandCard(command: command, description: description)
      });
    }

    return commandWidgetMap;
  }
}

class CommandCard extends StatelessWidget {
  const CommandCard({
    super.key,
    required this.command,
    required this.description,
  });

  final Command command;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 2.5, 16.0, 2.5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color.fromARGB(125, 0, 0, 0),
            width: 1,
          )),
      child: TextButton(
        child: GFListTile(
            titleText: command.name,
            subTitleText: description,
            focusColor: Colors.white,
            listItemTextColor: Colors.deepPurple),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => command,
            ),
          );
        },
      ),
    );
  }
}
