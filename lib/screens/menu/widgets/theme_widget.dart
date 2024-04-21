import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

//ignore: must_be_immutable
class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => ThemeChanger();
}

class ThemeChanger extends State<ThemeWidget> {
  /// Description: Change Theme widget
  static double iconSize = 24.0;

  Icon setIcon(){
    if(ThemeHandler.selectedTheme == "dark"){
      return Icon(
        Icons.wb_sunny_outlined,
        color: ThemeDefinition.accentColor,
        size: iconSize,
      );
    }

    return Icon(
      Icons.nights_stay_rounded,
      color: ThemeDefinition.accentColor,
      size: iconSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      setState(() {
        if(ThemeHandler.selectedTheme == "light") {
          ThemeHandler.setTheme("dark");
        }
        else {ThemeHandler.setTheme("light");}
      });
      ///restart app on theme change
      Phoenix.rebirth(context);
    },
      child: setIcon()
    );
  }
}