import 'package:flutter/material.dart';
import "dart:math";

import 'package:flutter_application_1/logic/command/command_logic.dart';
import 'package:flutter_application_1/screens/command/widgets/search_popup.dart';
import 'package:flutter_application_1/screens/command/widgets/bookmark_widget.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';
import 'package:flutter_application_1/theme/theme_handler.dart';
import 'package:flutter_application_1/utils/read_commands.dart';

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
    return Logic.getCommandDescription(command);
  }

  @override
  State<Command> createState() => CommandPage(command);
}

class CommandPage extends State<Command> {
  String pageTitle = "Command";
  Future? renderedFuture;

  /// list of command paragraphs and file sections
  List _commandParagraphs = [[]];
  List _commandSections = [''];

  /// check if command was loaded
  bool commandInit = false;

  /// search utility for storing paragraphs and keys
  Map<GlobalKey, String> searchUtility = {};

  @override
  CommandPage(String cName) {
    pageTitle = cName;
    renderedFuture = _renderCommand(pageTitle);
  }

  Future<String> _renderCommand(String commandName) async {
    String returnString = "";

    if (!commandInit) {
      commandInit = true;
      if (commandName == "random") {
        /// load a random command
        returnString = await _randomCommand();
      } else {
        /// load a given command
        returnString =  await _loadCommand(commandName);
      }
    }

    return returnString;
  }

  Future<String> _randomCommand() async {
    /// Description: loads the content of a random command

    /// reads all commands
    List commands = await readCommands();

    final intGenerator = Random();
    var element = commands[intGenerator.nextInt(commands.length)];

    /// load the selected command
    return _loadCommand(element);
  }

  Future<String> _loadCommand(String commandName) async {
    /// Description: load the content of a command
    var loadedCommand = await Logic.loadCommand(commandName);

    pageTitle = commandName;
    _commandSections = loadedCommand[1];
    _commandParagraphs = loadedCommand[2];

    return loadedCommand[0];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(pageTitle.replaceAll(".json", ""),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: ThemeDefinition.accentColor)),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),

                        ///renders search and bookmark widgets
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 50,
                                  child: popupSearchWidget(
                                      context, searchUtility)),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height: 50,
                                      child: BookmarkWidget(
                                          pageTitle.replaceAll(".json", "")),
                              )
                            ],
                          ),
                        ),

                        ///renders command body widget
                        ...Logic.renderCommand(_commandSections,
                            _commandParagraphs, searchUtility, context)
                      ],
                    ),
                  ));
            }
          }
          return const Center(
          );
        },
        future: renderedFuture);
  }
}
