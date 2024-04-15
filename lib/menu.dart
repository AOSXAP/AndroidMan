import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utils/readCommands.dart';
import 'command.dart';
import 'package:getwidget/getwidget.dart';
import "search.dart";
import 'dart:ui';

class StatefulMenu extends StatefulWidget {
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}

class Menu extends State<StatefulMenu> {
  List<Widget> menuEntries = [];
  static String searchedTerm = "";
  List<dynamic> commands = [];
  Map<String, Widget> commandWidgetMap = {};

  @override
  Menu() {
    _initAllMenuEntriesWidgets();
  }

  void _initAllMenuEntriesWidgets() async {
    Map<String, Widget> widgetMap = {};

    var commandList = await readCommand();

    //add first command - random command
    commandList = ["random", ...commandList];

    for (var command in commandList) {
      Command initCommand = Command(command);
      String description = "random command";

      if(command != "random") {
        description = await Command.listDescription(command);
      }

      if (description.length >= 200) {
        description = description.substring(0, 196) + " ...";
      }

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

    setState(() {
      commandWidgetMap = widgetMap;
    });
  }

  void initListOfCommands() async {
    menuEntries.clear();
    List<Widget> widgets = [];

    commandWidgetMap.forEach((key, value) {
      if(key.contains(searchedTerm)){
        widgets.add(value);
      }
    });

    setState(() {
      menuEntries = widgets;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 80, child: SearchWidget(this)),
      ...menuEntries,
    ]));
  }
}
