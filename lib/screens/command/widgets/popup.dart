import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

Future<void> dialogBuilder(BuildContext context, List<String> textToDisplay, String searchedTerm) {
  /// Description: returns a popup Dialog that displays all the paragraphs that contain searchedTerm
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      List<Widget> widgetList = [];

      if (textToDisplay.isEmpty) {
        /// searchedTerm wasn't found anywhere
        widgetList.add(const Text("Searched term not found"));
      } else {
        /// foreach paragraph (in which searchedTerm was found)
        for (String extractedText in textToDisplay) {
          List<TextSpan> textSpans = [];

          /// foreach word
          for (String word in extractedText.split(" ")) {
            ///if word matches/contains searchedTerm
            if (word.trim().contains(searchedTerm.trim())) {
              ///display decorated word
              textSpans.add(
                TextSpan(
                  text: '$word ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),
                ),
              );
            }

            /// else display undecorated word
            else {
              textSpans.add(
                TextSpan(
                  text: '$word ',
                ),
              );
            }
          }

          /// build final list of TextSpans
          widgetList.add(Container(
              margin: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(border: Border.all(color: AppColors.purple), borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Text.rich(TextSpan(children: <TextSpan>[...textSpans]))));
        }
      }

      ///return Popup Dialog
      return AlertDialog(
        // title: Text("Search results"),
        content: Container(
          width: 600,
          height: 700,
          child: ListView(
            children: [...widgetList],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).primaryColor),
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
