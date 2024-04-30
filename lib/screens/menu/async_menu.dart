import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/widgets/menu.dart';
import '../../logic/bookmark/bookmark_handler.dart';
import '../../theme/theme_definition.dart';
import '../../theme/theme_handler.dart';

/// This widget renders the entire menu section (including loading and setting theme)

class AsyncMenu extends StatelessWidget {
  const AsyncMenu({super.key});
  static const String _title = 'Command to run';
  static ThemeData selectedTheme = ThemeDefinition.darkTheme;

  /// Load async assets before displaying menu
  static Future<ThemeData> loadAssets(BuildContext context) async {
    await BookmarkHandler.getBookmarks();
    return await ThemeHandler.selectCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  /// Display error message if there is an error
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  /// If the data is loaded succesfully, the selected theme is set
                  final data = snapshot.data;
                  AsyncMenu.selectedTheme = data!;

                  /// Return the selected materialApp with the corresponding theme and menu
                  MaterialApp coreApp = MaterialApp(
                      title: _title,
                      theme: AsyncMenu.selectedTheme,
                      home: const StatefulMenu());
                  return coreApp;
                }
              }
              /// When this part of code runs, it displays a circulr indicator until the loadAssets function completes its
              /// execution. Once the assets are loaded, the FutureBuilder will build a widget with the loaded data
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: loadAssets(context)));
  }
}
