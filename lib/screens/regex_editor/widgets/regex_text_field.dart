import 'package:flutter/material.dart';


/// Input field widget
class RegexTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  int maxLines = 1;
  String displayName = "Text Field";

  RegexTextField(int mL, String dN, {super.key}){
    maxLines = mL;
    displayName = dN;
  }

  TextEditingController get control {
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: TextField(
            maxLines: maxLines,
            controller: controller,
            decoration:
              InputDecoration(
                labelText: displayName,
                fillColor: Theme.of(context).cardColor,
                filled: true
              )
        )
      );
    }
  }
