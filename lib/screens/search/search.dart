import 'package:flutter/material.dart';
import '../menu/menu.dart';

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

  @override
  Search(Menu passedMenu) {
    associatedMenu = passedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onSubmitted: (String storedText) {
          /// Update static attribute of menu
          Menu.searchedTerm = storedText;

          /// refresh menu and perform search
          associatedMenu.showMatchedCommands();
          return;
        },
        style: const TextStyle(color: Colors.deepPurple),
        cursorColor: Colors.deepPurple,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(16.0),
          labelText: 'Search command'
        ),
      ),
    ));
  }
}
