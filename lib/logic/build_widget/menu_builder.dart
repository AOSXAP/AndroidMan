import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/build_widget/route_builder.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import 'package:flutter_application_1/screens/command/command.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

class BuildMenu{
  static Future<Map<String, Widget>> buildCommandsWidgets(BuildContext context, List<dynamic> commandList) async {
    ///Description: Build all commands widget

    /// map commandName - Widget
    Map<String, Widget> widgetMap = {};

    /// add first command - random command
    commandList = ["random", ...commandList];

    for (var command in commandList) {
      /// init each command
      Command initCommand = Command(command);
      String description = "random command";

      if (command != "random") {
        ///read command description
        description = await Command.listDescription(command);
      }

      ///shorten description
      if (description.length >= 200) {
        description = '${description.substring(0, 196)} ...';
      }

      ///add command to widgetMap
      widgetMap.addAll({
        command.replaceAll(".json", ""): Container(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 2.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ThemeHandler.selectedTheme == "light" ? Colors.white : Colors.black38,
              border: Border.all(
                color: const Color.fromARGB(125, 0, 0, 0),
                width: 1,
              )),
          child: TextButton(
            child: GFListTile(
              titleText: command.replaceAll(".json", ""),
              subTitleText: description,
              listItemTextColor: ThemeDefinition.accentColor,
            ),
            onPressed: () {
              Navigator.of(context).push(FastRoutes.initRoute(initCommand, Duration(microseconds: 300)));
            },
          ),
        )
      });
    }
    return widgetMap;
  }
}