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

  @override
  Menu() {
    _readInitialCommands();
    _initListOfCommands();
  }

  void _readInitialCommands()async {
    commands = await readCommand();
  }

  void refreshCommands() {
    _initListOfCommands();
  }

  void _initListOfCommands() async {
    menuEntries.clear();

    for (var command in commands) {
      if (searchedTerm == "" || command.contains(searchedTerm)) {
        Command initCommand = Command(command);
        String description = await Command.listDescription(command);

        if (description.length >= 200) {
          description = description.substring(0, 196) + " ...";
        }
        setState(() {
          menuEntries.add(Container(
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
                listItemTextColor: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => initCommand,
                  ),
                );
              },
            ),
          ));
        });
      }
    }
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
