import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class JsonHandler {
  static Future<Map<String, dynamic>> loadJsonFromFile(String filePath) async {
    final String loadedData = await rootBundle.loadString(filePath);
    return decodeJsonString(loadedData);
  }

  static Map<String, dynamic> decodeJsonString(String data) {
    Map<String, dynamic> json = {};
    if (data.isNotEmpty) json = jsonDecode(data) as Map<String, dynamic>;
    return json;
  }
}
