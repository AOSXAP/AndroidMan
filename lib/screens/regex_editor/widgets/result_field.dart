import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/regex_editor/regex_editor.dart';
import 'package:flutter_application_1/theme/theme_definition.dart';

/// Widget will display the result of the Regex match
class ResultField extends StatelessWidget {
  List<TextSpan> textSpans = [];
  List<Widget> bodyWidget= [];

  ResultField(String pattern, String extractedText, {super.key}){
    ///regex magic

    if(extractedText.trim().isNotEmpty) {
      ///doing the match for each row
      extractedText.split('\n').forEach((row) {
        Iterable<RegExpMatch> matches = [];
        try {
          matches = RegexEditor.parseExpr(RegExp(pattern), '$row\n');
          buildResult('$row\n', matches);
        } catch (e) {
          bodyWidget.add(Text(e.toString()));
        }
      });
    }
  }

  TextSpan _buildSpan(String text, int start, int end, Color col, FontWeight w){
    return TextSpan(
        text:  '${text.substring(start , end)} ',
        style: TextStyle(color: col, fontWeight: w)
    );
  }

  TextSpan _emptySpan(Color col){
    return TextSpan(
        text:  'n',
        style: TextStyle(color: Colors.transparent, backgroundColor: col)
    );
  }



  void buildResult(String text, Iterable<RegExpMatch> matches){
    ///end of last match
    int lastEnd = 0;

    ///clear before building
    textSpans.clear();

    ///for each regex match
    for(RegExpMatch match in matches){
      int start = match.start;
      int end = match.end;

      ///display text between matches(aka unmatched)
      if(start - lastEnd >= 1) {
        textSpans.add(
            _buildSpan(text,lastEnd,start, Colors.grey, FontWeight.w300)
        );
      }

      ///display matched text
      textSpans.add(
          _buildSpan(text,start,end,ThemeDefinition.accentColor, FontWeight.w600)
      );

      ///handle empty spaces (/s,/n,...)
      if(text.substring(start,end).trim().isEmpty == true){
        textSpans.add(
            _emptySpan(ThemeDefinition.accentColor)
        );
      }

      lastEnd = end;
    }

    ///display what's after last match(unmatched seq)
    if(text.length - lastEnd >= 1){
      textSpans.add(
          _buildSpan(text,lastEnd,text.length,Colors.grey, FontWeight.w300)
      );
    }

    /// build final list of TextSpans
    bodyWidget.add(Text.rich(TextSpan(children: <TextSpan>[...textSpans])));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...bodyWidget
          ],
        )
    );
  }
}
