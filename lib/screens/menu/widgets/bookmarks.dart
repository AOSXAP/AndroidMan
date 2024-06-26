import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:flutter_application_1/logic/menu/menu_logic.dart';
import 'package:flutter_application_1/screens/menu/widgets/menu.dart';

//ignore: must_be_immutable
class BookmarksButtonWidget extends StatefulWidget {
  static Menu? men;
  /// Constructor to initialize the menu
  BookmarksButtonWidget(Menu menu, {super.key}) {
    men = menu;
  }
  @override
  State<BookmarksButtonWidget> createState() => BookmarkButton(men!);
}

class BookmarkButton extends State<BookmarksButtonWidget> {
  /// Static variable to hold the menu
  static Menu? menu;
  /// Variable to track button selection
  static bool selected = false;
  GFButtonType buttonT = GFButtonType.outline;
  Color fontColor = ThemeDefinition.accentColor;

  BookmarkButton(Menu m) {
    menu = m;
  }
  /// Function to toggle button type and font color
  void buildButtonType() {
    selected = !selected;

    setState(() {
      if (selected == true) {
        buttonT = GFButtonType.solid;
        fontColor = Colors.white;
        if (ThemeHandler.selectedTheme == "dark") {
          fontColor = Colors.black87;
        }
      } else {
        buttonT = GFButtonType.outline;
        fontColor = ThemeDefinition.accentColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GFButtonBadge(
        onPressed: () {
          setState(() {
            /// Toggle button type and font color
            buildButtonType();
            /// Update menu entries based on button state
            if (menu != null && selected) {
              menu!.updateMenuEntries(Logic.loadBookmarks(
                  Menu.menuEntries, Menu.commandWidgetMap, Menu.searchedTerm));
            } else {
              menu!.updateMenuEntries(Logic.loadSearchedTerm(
                  Menu.menuEntries, Menu.commandWidgetMap, Menu.searchedTerm));
            }
          });
        },
        color: ThemeDefinition.accentColor,
        textColor: fontColor,
        text: "Bookmarked",
        type: buttonT,
      ),
    );
  }
}
