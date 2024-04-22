import 'package:flutter/material.dart';

import 'package:flutter_application_1/logic/appdata/appdata.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

class ThemeHandler{
  static String selectedTheme = "light";
  static Color fontColor = Colors.white;

  static get fontCol{
    fontColor = ThemeDefinition.accentColor;

    if(ThemeHandler.selectedTheme == "dark"){
      fontColor = Colors.white;
    }

    return fontColor;
  }


  static Future<String> getTheme() async {
    /// Load current theme
    AppData.initData();

    try {
      selectedTheme = AppData.getPreference("theme")!;
    }catch(e){
      /// Init theme if it wasn't
      await AppData.setPreference("theme", "light");
    }
    return selectedTheme;
  }

  static void setTheme(String theme)async{
    AppData.initData();

    if(theme == "dark" || theme == "light") {
      ThemeHandler.selectedTheme = theme;
      await AppData.setPreference("theme", theme);
    }
  }

  static Future<ThemeData> selectCurrentTheme()async{
    await ThemeHandler.getTheme();

    if(selectedTheme == "dark"){
      return ThemeDefinition.darkTheme;
    }
    return ThemeDefinition.lightTheme;
  }
}