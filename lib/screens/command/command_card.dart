import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'command.dart';

class CommandCard extends StatelessWidget {
  const CommandCard({
    super.key,
    required this.command,
    required this.description,
  });

  final Command command;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 2.5, 16.0, 2.5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color.fromARGB(125, 0, 0, 0),
            width: 1,
          )),
      child: TextButton(
        child: GFListTile(titleText: command.name, subTitleText: description, focusColor: Colors.white, listItemTextColor: Colors.deepPurple),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => command,
            ),
          );
        },
      ),
    );
  }
}
