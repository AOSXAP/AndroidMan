import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/readCommands.dart';
import "../search/search.dart";
import '../../logic/command/menu_handler.dart';

class StatefulMenu extends StatefulWidget {
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}

class Menu extends State<StatefulMenu> {
  List<Widget> menuEntries = [];
  static String searchedTerm = "";
  Map<String, Widget> commandWidgetMap = {};

  @override
  Menu() {
    initMenu();
  }

  void initMenu() async {
    ///Description: init Menu
    ///Input: void
    ///Output: void

    /// read all commands
    List<String> commandList = await getAllAvailableCommands();

    /// map commandName - Widget
    Map<String, Widget> widgetMap = await MenuHandler.loadCommandsFromMemory(context, commandList);

    setState(() {
      ///update global map
      commandWidgetMap = widgetMap;
    });
  }

  void showMatchedCommands() {
    ///Description: reload menu and reset entries
    ///Input: void
    ///Output: void
    menuEntries.clear();
    setState(() {
      menuEntries = MenuHandler.getMatchedCommands(commandWidgetMap, searchedTerm);
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
