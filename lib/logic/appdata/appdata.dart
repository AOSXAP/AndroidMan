import 'package:shared_preferences/shared_preferences.dart';

/// Module for disk access

class AppData{
  //? == data could be null
  static SharedPreferences? data;

  static Future<void> initData() async {
    /// ensure AppData is init
      AppData.data ??= await AppData.readData();
  }

  static Future<SharedPreferences> readData() async{
    return await SharedPreferences.getInstance();
  }

  static String? getPreference(String pref){
    return data?.getString(pref);
  }

  static Future<void> setPreference(String field, String val) async{
    await data?.setString(field, val);
  }

  static List<String>? getPreferenceList(String prefListName){
    return data?.getStringList(prefListName);
  }

  static Future<void> setPreferenceList(String field, List<String> values) async{
    await data?.setStringList(field, values);
  }

  static Future<void> removePreference(String pref) async{
    await data?.remove(pref);
  }
}