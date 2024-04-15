import 'package:flutter/material.dart';
import '../../screens/command/command.dart';
import 'package:getwidget/getwidget.dart';

class Logic{
  static List<Widget> reloadMenu(List<Widget> menuEntries, Map<String, Widget> commandWidgetMap, String searchedTerm ){
    /// reset actual menu
    menuEntries.clear();

    /// create new list of widgets
    List<Widget> widgets = [];

    /// foreach widget in all loaded widgets
    commandWidgetMap.forEach((key, value) {
      /// if name of widget contains searchedTerm
      if(key.contains(searchedTerm)){
        widgets.add(value);
      }
    });

    /// reload Widgets
    return widgets;
  }

  static Future<Map<String, Widget>> loadData(var context, var commandList) async {
    ///Description: Load all commands and data
    ///Input: Context, List
    ///Output: Map<String, Widget>

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
                titleText: command.replaceAll(".json", ""),
                subTitleText: description,
                focusColor: Colors.white,
                listItemTextColor: Colors.deepPurple
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => initCommand,
                ),
              );
            },
          ),
        )
      });
    }
    return widgetMap;
  }
}