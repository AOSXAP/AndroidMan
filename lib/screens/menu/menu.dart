import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/menu/theme_widget.dart';
import 'package:flutter_application_1/utils/read_commands.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../theme/theme_handler.dart';
import "search/search.dart";
import '../../logic/command/menu_logic.dart';

/// This widget displays a menu with all commands and a widget
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

    /// read all commands
    var commandList = await readCommand();

    /// map commandName - Widget
    Map<String, Widget> widgetMap = await Logic.loadData(context, commandList);
    menuEntries = Logic.reloadMenu(menuEntries, widgetMap, searchedTerm);

    setState(() {
      ///update global map
      commandWidgetMap = widgetMap;
    });
  }

  void reloadMenu() {
    ///Description: reload menu and reset entries
    setState(() {
      menuEntries =
          Logic.reloadMenu(menuEntries, commandWidgetMap, searchedTerm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 80, child: SearchWidget(this)),
          const SizedBox(height: 80, child: ThemeWidget()),
          ...menuEntries,
        ])));
  }
}
