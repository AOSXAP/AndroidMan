import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/readCommands.dart';
import 'command.dart';
import 'dart:math';
import 'package:getwidget/getwidget.dart';

class StatefulMenu extends StatefulWidget{
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}


class Menu extends State<StatefulMenu>{
  List<Widget> menuEntries=[GFButton(
    onPressed: (){},
    text:"primary"
)];
  

  @override
  Menu(){
    _initListOfCommands();
  }

  void _initListOfCommands() async{
    List commands = await readCommand();

    for(var command in commands){
      Command initCommand = Command(command);
      String description = await Command.listDescription(command);

      if(description.length >= 200){
        description = description.substring(0,196) + " ...";
      }
      setState(() {
            menuEntries.add(TextButton(
            child: 
             GFListTile(
              titleText: command,
              subTitleText:description,
              listItemTextColor: Colors.white,
            ),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => initCommand,
              ),
            );
          },
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          ...menuEntries,
        ]
      )
    );
  }
}