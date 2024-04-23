import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefServices{
  static SharedPreferences? _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }
  static Future<void> setValue(String key,dynamic value) async {
    if(value is String){
      await _pref!.setString(key, value);
    }
    else if(value is int){
      await _pref!.setInt(key, value);
    }
    else if(value is bool){
      await _pref!.setBool(key, value);
    }
    else if(value is double){
      await _pref!.setDouble(key, value);
    }
    else if(value is List<String>){
      await _pref!.setStringList(key, value);
    }
    else{
      Get.snackbar("Preference Error","Send valid value for store data in preference");
    }
  }

  static String getString(String key){
    return _pref!.getString(key) ?? "";
  }
  static int getInt(String key){
    return _pref!.getInt(key) ?? 0;
  }
  static double getDouble(String key){
    return _pref!.getDouble(key) ?? 0.0;
  }
  static bool getBool(String key){
    return _pref!.getBool(key) ?? false;
  }
  static List<String> getStringList(String key){
    return _pref!.getStringList(key) ?? [];
  }
  static Future<void> removeValue(String key) async {
    await _pref!.remove(key);
  }
}