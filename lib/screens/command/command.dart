import 'package:flutter/material.dart';
import '../../utils/readCommands.dart';
import "dart:math";
import '../../logic/command/command_logic.dart';
import 'search_popup.dart';

//ignore: must_be_immutable
class Command extends StatefulWidget {
  /// default command
  String command = "ls.json";

  @override
  Command(String commandName, {super.key}) {
    /// adding .json to commandName for easier handling afterwards
    if (!commandName.contains(".json") && commandName != "random") {
      commandName += ".json";
    }

    command = commandName;
  }

  static Future<String> listDescription(String command) async {
    /// Description: This function returns the description of a given command
    /// Input: String
    /// Output: Future <String>

    return Logic.getCommandDescription(command);
  }

  @override
  State<Command> createState() => CommandPage(command);
}

class CommandPage extends State<Command> {
  static String pageTitle = "Command";

  /// list of command paragraphs
  List _commandParagraphs = [[]];

  /// list of file sections
  List _commandSections = [''];

  /// index of sections
  static int index = 0;

  /// search utility for storing paragraphs and keys
  Map<GlobalKey,String> searchUtility = {};

  @override
  CommandPage(String commandName) {
    if (commandName == "random"){
      /// load a random command
      _randomCommand();
    }
    else{
      /// load a given command
      _loadCommand(commandName);
    }
  }

  void _randomCommand() async {
    /// Description: loads the content of a random command
    /// Input: void
    /// Output: void

    /// reads all commands
    List commands = await readCommand();

    /// generate a random int between 0 and commands.length
    final intGenerator = Random();

    var element = commands[intGenerator.nextInt(commands.length)];

    /// load the selected command
    _loadCommand(element);
  }

  void _loadCommand(String commandName) async {
    /// Description: load the content of a command
    /// Input: String
    /// Output: void

    var loadedCommand = await Logic.loadCommand(commandName);

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
        title: Text(pageTitle,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            ///renders search widget
            popupSearchWidget(context,searchUtility),
            ///renders command body widget
            ...Logic.renderCommand(_commandSections,_commandParagraphs,searchUtility)
          ],
        ),
      ),
    );
  }
}
