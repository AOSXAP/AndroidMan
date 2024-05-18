import 'package:flutter/material.dart';

import 'popup.dart';

Widget popupSearchWidget(BuildContext context, Map<GlobalKey, String> searchUtility) {
  /// Description: returns a search widget that on submit launches a popup

  return FractionallySizedBox(
      widthFactor: 1, // between 0 and 1
      child: SizedBox(
          child: TextField(
        onSubmitted: (String searchedTerm) {
          /// List of paragraphs
          List<String> collectedText = [];

          /// foreach paragraph
          for (MapEntry<GlobalKey, String> item in searchUtility.entries) {
            /// if paragraph contains the searchedTerm, store it
            if (item.value.contains(searchedTerm)) {
              collectedText.add(item.value);
            }
          }

          /// launch popup Dialog
          dialogBuilder(context, collectedText, searchedTerm);
        },
        onEditingComplete: () {},

        /// keep keyboard on
        style: Theme.of(context).textTheme.bodyLarge,
        cursorColor: Colors.deepPurple,
        decoration: const InputDecoration(contentPadding: EdgeInsets.all(6.0), labelText: 'Search'),
      )));
}
