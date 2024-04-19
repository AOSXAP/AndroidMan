import 'package:flutter/material.dart';
import '../build_widget/menu_builder.dart';

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

  static Future<Map<String, Widget>> loadData(BuildContext context, List<dynamic> commandList) async {
    ///Description: Load all commands and data
    return await BuildMenu.buildCommandsWidgets(context, commandList);
  }
}