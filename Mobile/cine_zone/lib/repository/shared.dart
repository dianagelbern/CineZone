import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static late SharedPreferences _prefs;

  static Future<bool> setString(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
