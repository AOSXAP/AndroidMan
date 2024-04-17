import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/command/string_handler.dart';
import '../../utils/readCommands.dart';
import "dart:math";
import '../../logic/command/command_handler.dart';
import 'search_popup.dart';

//ignore: must_be_immutable
class Command extends StatefulWidget {
  /// default command
  String _commandName = "ls";
  String get name => _commandName;

  @override
  Command(String commandName, {super.key}) {
    _commandName = commandName;
  }

  static Future<String> listDescription(String command) async {
    return CommandHandler.getCommandDescription(command);
  }

  @override
  State<Command> createState() => CommandPage(_commandName);
}

class CommandPage extends State<Command> {
  static String pageTitle = "Command";

  List _commandSections = ['no_section'];
  List _commandParagraphs = [
    ['empty paragraph']
  ];

  static int index = 0;

  /// search utility for storing paragraphs and keys
  Map<GlobalKey, String> searchUtility = {};

  @override
  CommandPage(String commandName) {
    if (commandName == "random") {
      /// load a random command
      _randomCommand();
    } else {
      /// load a given command
      _loadCommand(commandName);
    }
  }

  void _randomCommand() async {
    List commands = await getAllAvailableCommands();
    final int randomListIndex = Random().nextInt(commands.length);
    String element = StringHandler.removeExtensionFromFileName(commands[randomListIndex], '.json');
    _loadCommand(element);
  }

  void _loadCommand(String commandName) async {
    /// Description: load the content of a command
    /// Input: String
    /// Output: void

    var loadedCommand = await CommandHandler.loadCommand(commandName);

    /// load resources
    setState(() {
      pageTitle = loadedCommand[0];
      _commandSections = loadedCommand[1];
      _commandParagraphs = loadedCommand[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle, style: const TextStyle(fontSize: 30, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            ///renders search widget
            popupSearchWidget(context, searchUtility),

            ///renders command body widget
            ...CommandHandler.renderCommand(_commandSections, _commandParagraphs, searchUtility)
          ],
        ),
      ),
    );
  }
}
