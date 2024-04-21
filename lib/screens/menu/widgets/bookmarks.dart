import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/widgets/search.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import '../../../logic/menu/menu_logic.dart';
import 'package:getwidget/getwidget.dart';
import 'menu.dart';

//ignore: must_be_immutable
class BookmarksButtonWidget extends StatefulWidget
{
  static Menu? men;
  BookmarksButtonWidget(Menu menu, {super.key}){
    men = menu;
  }
  @override
  State<BookmarksButtonWidget> createState() => BookmarkButton(men!);
}

class BookmarkButton extends State<BookmarksButtonWidget> {
  static Menu? menu;
  static bool selected = false;
  GFButtonType buttonT = GFButtonType.outline;
  Color fontColor = ThemeDefinition.accentColor;

  BookmarkButton(Menu m){
    menu = m;
  }

  void buildButtonType(){
    selected = !selected;

    setState(() {
      if(selected == true){
        buttonT =  GFButtonType.solid;
        fontColor = Colors.white;
        if(ThemeHandler.selectedTheme == "dark"){
          fontColor = Colors.black87;
        }
      }else {
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
            buildButtonType();
            if(menu != null) {
              menu!.updateMenuEntries(Logic.loadBookmarks(
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
