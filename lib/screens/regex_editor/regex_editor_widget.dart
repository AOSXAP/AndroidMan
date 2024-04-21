import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/regex_editor/regex_editor.dart';
import 'package:flutter_application_1/screens/regex_editor/widgets/regex_text_field.dart';
import 'package:flutter_application_1/screens/regex_editor/widgets/result_field.dart';
import 'package:getwidget/getwidget.dart';

import 'package:flutter_application_1/theme/theme_definition.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:flutter_application_1/logic/menu/menu_logic.dart';
import 'package:flutter_application_1/screens/menu/widgets/menu.dart';

//ignore: must_be_immutable
class RegexEditorWidget extends StatefulWidget {
  const RegexEditorWidget({super.key});

  @override
  State<RegexEditorWidget> createState() => StatefulRegexWidget();
}

class StatefulRegexWidget extends State<RegexEditorWidget> {
  /// editing controls to get and manipulate input text
  TextEditingController commandController = TextEditingController();
  TextEditingController textController = TextEditingController();

  /// input fields
  static RegexTextField commandTextField = RegexTextField(1, "Regex Command");
  static RegexTextField bodyTextField = RegexTextField(10, "Text");

  String matches = "";
  String extractedText = "";

  StatefulRegexWidget() {
    commandController = commandTextField.control;
    textController = bodyTextField.control;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Regex Editor",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: ThemeDefinition.accentColor)),
        ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commandTextField,
          bodyTextField,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: GFButton(
                  text: "Match",
                  color: ThemeHandler.selectedTheme == "light" ? Colors.deepPurple: Colors.white,
                  textColor: ThemeHandler.selectedTheme == "light" ? Colors.white: Colors.black87,
                  onPressed: () {
                    setState(() {
                      matches = commandController.text;
                      extractedText = textController.text;
                    });
                  })),
          SizedBox(
            child: ResultField(matches, extractedText),
          )
        ],
      )),
    ));
  }
}
