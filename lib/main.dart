import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/menu/menu.dart';
import 'utils/read_commands.dart';
import 'theme/theme_definition.dart';
import 'theme/theme_handler.dart';
import 'screens/menu/future_menu.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static Key appKey = UniqueKey();

  const MyApp({super.key});

  void refresh(BuildContext context){
    build(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child:const SectionMenu()
    );
  }
}
