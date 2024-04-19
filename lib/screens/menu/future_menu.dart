import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/menu.dart';
import '../../utils/read_commands.dart';
import '../../theme/theme_definition.dart';
import '../../theme/theme_handler.dart';

/// This widget renders the entire menu section (including loading and setting theme)
class SectionMenu extends StatelessWidget {
  const SectionMenu({super.key});
  static const String _title = 'Command to run';
  static ThemeData selectedTheme = ThemeDefinition.lightTheme;

  /// load async assets before displaying menu
  Future<ThemeData> loadAssets() async {
    await readCommand();
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
                  SectionMenu.selectedTheme = data!;

                  MaterialApp coreApp = MaterialApp(
                      title: _title,
                      theme: SectionMenu.selectedTheme,
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
