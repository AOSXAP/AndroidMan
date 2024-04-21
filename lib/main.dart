import 'package:flutter/material.dart';
import 'screens/menu/async_menu.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static Key appKey = UniqueKey();

  const MyApp({super.key});

  void refresh(BuildContext context){
    build(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child:const AsyncMenu()
    );
  }
}
