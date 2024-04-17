import 'package:flutter/material.dart';

import '../../screens/command/command.dart';
import '../../screens/command/command_card.dart';
import 'string_handler.dart';

class MenuHandler {
  static List<Widget> getMatchedCommands(Map<String, Widget> commandWidgetMap, String searchedTerm) {
    return commandWidgetMap.entries.where((e) => e.key.contains(searchedTerm)).map((e) => e.value).toList();
  }

  static Future<Map<String, Widget>> loadCommandsFromMemory(BuildContext context, List<String> commandList) async {
    Map<String, Widget> commandWidgetMap = {};
    commandList = StringHandler.removeExtensionsFromFileName(["random", ...commandList], ".json");

    for (String commandName in commandList) {
      Command command = Command(commandName);
      String description = "random command";

      if (commandName != "random") {
        description = await Command.listDescription(commandName);
      }

      description = StringHandler.shortenDescription(description);
      commandWidgetMap.addAll({commandName: CommandCard(command: command, description: description)});
    }

    return commandWidgetMap;
  }
}
