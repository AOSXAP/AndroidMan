import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utils/readCommands.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'command.dart';
import 'dart:math';
import 'package:getwidget/getwidget.dart';
import "search.dart";
import 'dart:ui';

class StatefulMenu extends StatefulWidget{
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}


class Menu extends State<StatefulMenu>{
  List<Widget> menuEntries=[];
  static String searchedTerm = "ls";

  @override
  Menu(){
    _initListOfCommands();
  }

  void refreshCommands(){
    _initListOfCommands();
  }

  void _initListOfCommands() async{
    menuEntries.clear();
    List commands = await readCommand();

    for(var command in commands){
      if(searchedTerm == "" || command.contains(searchedTerm)){
      Command initCommand = Command(command);
      String description = await Command.listDescription(command);

      if(description.length >= 200){
        description = description.substring(0,196) + " ...";
      }
      setState(() {
            menuEntries.add(TextButton(
            child: 
             GFListTile(
              titleText: command.replaceAll(".json",""),
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
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          SizedBox(height:80, child:SearchWidget(this)),
          ...menuEntries,
        ]
      )
    );
  }
}