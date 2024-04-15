import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

Future<void> dialogBuilder(BuildContext context, List<String> textToDisplay, String searchedTerm) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      List<Widget> widgetList = [];

      if(textToDisplay.isEmpty){
        widgetList.add(const Text("Searched term not found"));
      }
      else{
        for(String extractedText in textToDisplay) {
          List<TextSpan> textSpans = [];

          for (String word in extractedText.split(" ")) {
            if (word.trim().contains(searchedTerm.trim())) {
              textSpans.add(
                TextSpan(
                  text: word + " ",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              );
            }
            else {
              textSpans.add(
                TextSpan(
                  text: word + " ",
                ),
              );
            }
          }
          widgetList.add(Text.rich(TextSpan(children: <TextSpan>[...textSpans])));
        }
      }

      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [...widgetList]
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
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
