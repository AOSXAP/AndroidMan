import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';
import 'menu.dart';

//ignore: must_be_immutable
class SearchWidget extends StatefulWidget {
  late Menu currentMenu;

  @override
  SearchWidget(Menu passedMenu, {super.key}) {
    currentMenu = passedMenu;
  }

  @override
  State<SearchWidget> createState() => Search(currentMenu);
}

class Search extends State<SearchWidget> {
  /// Description: Search widget

  /// Menu in which the search will be performed
  late Menu associatedMenu;
  static final TextEditingController control  = TextEditingController();

  @override
  Search(Menu passedMenu) {
    associatedMenu = passedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: control,
        onSubmitted: (String storedText) {
          /// Update static attribute of menu
          Menu.searchedTerm = storedText;
          /// refresh menu and perform search
          associatedMenu.reloadMenu();
          return;
        },
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: ThemeDefinition.accentColor,
        ),
        cursorColor: Colors.deepPurple,
        decoration: InputDecoration(
          labelText: "Search Command",
          fillColor: Theme.of(context).cardColor,
          filled: true
        ),
      ),
    ));
  }
}
