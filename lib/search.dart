import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'menu.dart';

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
  static String value = "";
  late Menu associatedMenu;

  @override
  Search(Menu passedMenu) {
    associatedMenu = passedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onSubmitted: (String storedText) {
          value = storedText;
          Menu.searchedTerm = storedText;
          associatedMenu.refreshCommands();
          return;
        },
        style: const TextStyle(color: Colors.deepPurple),
        cursorColor: Colors.deepPurple,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search command',
          contentPadding: EdgeInsets.all(20.0),
        ),
      ),
    ));
  }
}

// appBar: GFAppBar(searchBar: true, title: const Text("AndroidMan")));
