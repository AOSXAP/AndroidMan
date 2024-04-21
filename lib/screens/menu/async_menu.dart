import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/bookmark/bookmark_handler.dart';
import 'package:flutter_application_1/screens/menu/widgets/menu.dart';
import '../../utils/read_commands.dart';
import '../../theme/theme_definition.dart';
import '../../theme/theme_handler.dart';

/// This widget renders the entire menu section (including loading and setting theme)

class AsyncMenu extends StatelessWidget {
  const AsyncMenu({super.key});
  static const String _title = 'Command to run';
  static ThemeData selectedTheme = ThemeDefinition.lightTheme;

  /// load async assets before displaying menu
  static Future<ThemeData> loadAssets() async {
    await readCommand();
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
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  AsyncMenu.selectedTheme = data!;

                  MaterialApp coreApp = MaterialApp(
                      title: _title,
                      theme: AsyncMenu.selectedTheme,
                      home: const StatefulMenu());
                  return coreApp;
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: loadAssets()));
  }
}
