import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../logic/bookmark/bookmark_handler.dart';
import '../../../theme/theme_definition.dart';

//ignore: must_be_immutable
class BookmarkWidget extends StatefulWidget {
  static String? command;

  BookmarkWidget(String c, {super.key}){
    command = c;
  }

  @override
  State<BookmarkWidget> createState() => StatefulBookmarkWidget(command!);
}

class StatefulBookmarkWidget extends State<BookmarkWidget> {
  /// Description: Bookmark widget
  static String? commandName;
  List<String> bookmarks = [];

  StatefulBookmarkWidget(String c){
    commandName = c;
    bookmarks = BookmarkHandler.bookmarks;
  }

  Icon getIcon(){
    if(commandName != null) {
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
    return TextButton(
        onPressed: () {
          if(commandName != null) {
            if(bookmarks.contains(commandName!)){
              bookmarks.remove(commandName!);
            }else {
              bookmarks.add(commandName!);
            }
          }

          BookmarkHandler.setBookmarks(bookmarks);
          setState(() {});

          print(BookmarkHandler.bookmarks);
        },
        child: getIcon()
    );
  }
}
