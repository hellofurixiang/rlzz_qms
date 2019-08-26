import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class LocalStorage {
  static saveBool(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, val);
  }

  static saveDouble(String key, double val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, val);
  }

  static saveString(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, val);
  }

  static saveInt(String key, int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, val);
  }

  static saveListStr(String key, List<String> val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, val);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
