import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/bookmark/bookmark_handler.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

//ignore: must_be_immutable
class BookmarkWidget extends StatefulWidget {
  // Static variable to store the command
  static String? command;

  // Constructor to initialize the command
  BookmarkWidget(String c, {super.key}) {
    command = c;
  }

  @override
  State<BookmarkWidget> createState() => StatefulBookmarkWidget(command!);
}

class StatefulBookmarkWidget extends State<BookmarkWidget> {
  /// Description: Bookmark widget
  static String? commandName;
  List<String> bookmarks = [];

  // Constructor to set the command name and initialize bookmarks list
  StatefulBookmarkWidget(String c) {
    commandName = c;
    bookmarks = BookmarkHandler.bookmarks;
  }

  // Function to get the appropriate bookmark icon based on the command
  Icon getIcon() {
    if (commandName != null) {
      if (bookmarks.contains(commandName!)) {
        return Icon(
          Icons.bookmark_added_rounded,
          color: ThemeDefinition.accentColor,
          size: 24.0,
        );
      }
    }

    return Icon(
      Icons.bookmark_border_outlined,
      color: ThemeDefinition.accentColor,
      size: 24.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Build the bookmark button
    return TextButton(
        onPressed: () {
          if (commandName != null) {
            if (bookmarks.contains(commandName!)) {
              bookmarks.remove(commandName!);
            } else {
              bookmarks.add(commandName!);
            }
          }

          BookmarkHandler.setBookmarks(bookmarks);
          setState(() {});
        },
        child: getIcon());
  }
}
