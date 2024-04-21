class RegexEditor{
  static Iterable<RegExpMatch> parseExpr(RegExp exp, String parseString){
    try{
      return exp.allMatches(parseString);
    }catch(e){}
    return [];
  }

  static List<String> parseMatches(Iterable<RegExpMatch> matches){
    List<String> stringMatches = [];

    for(var match in matches){
      print('${match.start} ${match.end}');
      if(match[0] != null) {
        stringMatches.add(match[0]!);
      }
    }

    return stringMatches;
  }
}