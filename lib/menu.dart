import 'package:flutter/material.dart';
import 'command.dart';

class StatefulMenu extends StatefulWidget{
  @override
  State<StatefulMenu> createState() => Menu();
}

class Menu extends State<StatefulMenu>{
  List<Widget> listMMM=[];
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          ...listMMM,
          TextButton(
            onPressed: () {
              setState(() {
                listMMM.add(const Text("muie"));
              });
                
            }, 
            child: const Text("Rapadunga"),
          )
        ]
      )
    );
  }
}