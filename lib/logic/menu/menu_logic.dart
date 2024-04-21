import 'package:flutter/material.dart';

import 'package:flutter_application_1/logic/bookmark/bookmark_handler.dart';
import 'package:flutter_application_1/logic/build_widget/menu_builder.dart';

class Logic{
  static List<Widget> loadSearchedTerm(List<Widget> menuEntries, Map<String, Widget> commandWidgetMap, String searchedTerm ){
    ///loads all widgets that match the searched term

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

  static List<Widget> loadBookmarks(List<Widget> menuEntries, Map<String, Widget> commandWidgetMap, String searchedTerm){
    /// reset actual menu
    menuEntries.clear();

    List<Widget> widgets = [];

    commandWidgetMap.forEach((key, value) {
        if(BookmarkHandler.bookmarks.contains(key) && key.contains(searchedTerm)){
          widgets.add(value);
        }
    });

    return widgets;
  }

  static Future<Map<String, Widget>> loadData(BuildContext context, List<dynamic> commandList) async {
    ///Description: Load all commands and data
    return await BuildMenu.buildCommandsWidgets(context, commandList);
  }
}