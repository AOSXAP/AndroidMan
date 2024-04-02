import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/readCommands.dart';
import 'command.dart';

class StatefulMenu extends StatefulWidget{
  @override
  const StatefulMenu({super.key});

  @override
  State<StatefulMenu> createState() => Menu();
}

class Menu extends State<StatefulMenu>{
  List<Widget> menuEntries=[];

  @override
  Menu(){
    _initListOfCommands();
  }

  void _initListOfCommands() async{
    List commands = await readCommand();

    setState(() {
      for(var command in commands){
        menuEntries.add(TextButton(
            child: Text(command),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Command(command),
              ),
            );
          },
        ));
      }
    });
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