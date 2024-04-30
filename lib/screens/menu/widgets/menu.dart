import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/build_widget/route_builder.dart';
import 'package:flutter_application_1/screens/menu/widgets/bookmarks.dart';
import 'package:flutter_application_1/screens/menu/widgets/theme_widget.dart';
import 'package:flutter_application_1/screens/regex_editor/regex_editor_widget.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:flutter_application_1/utils/read_commands.dart';
import 'package:getwidget/getwidget.dart';
import "search.dart";
import '../../../logic/menu/menu_logic.dart';

/// This widget displays a menu with all commands and a widget
class StatefulMenu extends StatefulWidget {
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}

class Menu extends State<StatefulMenu> {
  static List<Widget> menuEntries = [];
  static String searchedTerm = "";
  static Map<String, Widget> commandWidgetMap = {};

  @override
  Menu() {
    initMenu();
  }

  void initMenu() async {
    /// Description: init Menu
    var commands = await readCommands();

    /// map commandName - Widget
    Map<String, Widget> widgetMap = await Logic.loadData(context, commands);

    menuEntries = [];
    for (var comm in widgetMap.entries) {
      menuEntries.add(comm.value);
    }

    setState(() {
      /// Update global map
      commandWidgetMap = widgetMap;
    });
  }

  void updateMenuEntries(List<Widget> newMenuEntries) {
    setState(() {
      menuEntries = newMenuEntries;
    });
  }

  void reloadMenu() {
    /// Description: reload menu and reset entries
    setState(() {
      if (BookmarkButton.selected == false) {
        menuEntries =
            Logic.loadSearchedTerm(menuEntries, commandWidgetMap, searchedTerm);
      } else {
        menuEntries =
            Logic.loadBookmarks(menuEntries, commandWidgetMap, searchedTerm);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Build the menu UI
    return Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(children: [
            SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.85,
                child: SearchWidget(this)),
            SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.15,
                child: const ThemeWidget()),
          ]),
          Row(children: [
            BookmarksButtonWidget(this),
            GFButton(
                text: "Regex",
                highlightColor: Theme.of(context).cardColor,
                textColor: ThemeHandler.fontCol,
                color: Theme.of(context).cardColor,
                onPressed: () async {
                  Navigator.of(context).push(FastRoutes.initRoute(
                      const RegexEditorWidget(), Duration.zero));
                })
          ]),
          ...menuEntries,
        ])));
  }
}
