import 'package:shared_preferences/shared_preferences.dart';

/// Module for disk access

class AppData{
  //? == data could be null
  static SharedPreferences? data;

  static void initData(){
    /// ensure AppData is init
    if(AppData.data == null) {
      AppData.readData().then((d){
        AppData.data = d;
      });
    }
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

  static Future<void> removePreference(String pref) async{
    await data?.remove(pref);
  }
}