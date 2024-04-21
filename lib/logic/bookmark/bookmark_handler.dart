import 'package:flutter_application_1/logic/appdata/appdata.dart';

class BookmarkHandler{
  static List<String> bookmarks = [];

  static Future<List<String>> getBookmarks() async {
    await AppData.initData();

    try {
      bookmarks = AppData.getPreferenceList("bookmarks")!;
    }catch(e){
      await AppData.setPreferenceList("bookmarks", []);
    }

    return bookmarks;
  }

  static void setBookmarks(List<String> values)async{
    AppData.initData();
    bookmarks = values;

    await AppData.setPreferenceList("bookmarks", <String>[...values]);
  }
}