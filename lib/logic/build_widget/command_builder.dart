import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

class BuildCommand{
  static List<Widget> buildWidget(List commandSections, List commandParagraphs, Map<GlobalKey,String> searchUtility, BuildContext context) {
    /// Description: Build Command Page Widget

    /// Widget Body
    List<Widget> renderBody = [];

    /// child of Widget,stores paragraphs
    List<Widget> renderChild = [];

    /// foreach section
    for (int i = 0; i < commandSections.length - 1; i++) {
      renderChild = [];
      /// foreach paragraph in current section
      for (int j = 0; j < commandParagraphs[i].length; j++) {
        ///generate key
        GlobalKey paragraphKey =  GlobalKey();

        ///add paragraph to search utility
        searchUtility[paragraphKey] = commandParagraphs[i][j];

        renderChild.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            key: paragraphKey,
            child: SelectableText(commandParagraphs[i][j],
                style: TextStyle(
                  color: ThemeDefinition.accentColor,
                ))));
      }

      /// build render Widget
      renderBody.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commandSections[i + 1], /// Command Section Name
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          color: ThemeDefinition.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    ...renderChild
                  ],
                ),
              ))));
    }
    return renderBody;
  }
}