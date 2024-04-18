import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../theme/theme_handler.dart';

//ignore: must_be_immutable
class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => ThemeChanger();
}

class ThemeChanger extends State<ThemeWidget> {
  /// Description: Change Theme widget
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
      child: const Text("change Theme")
    );
  }
}
