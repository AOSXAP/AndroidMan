class StringHandler {
  static List<String> removeExtensionsFromFileName(List<String> commands, String extension) {
    return commands.map((command) => command.replaceAll(extension, '')).toList();
  }

  static String removeExtensionFromFileName(String command, String extension) {
    return command.replaceAll(extension, '');
  }

  static String shortenDescription(String description) {
    if (description.length < 200) return description;
    return '${description.substring(0, 196)} ...';
  }
}
