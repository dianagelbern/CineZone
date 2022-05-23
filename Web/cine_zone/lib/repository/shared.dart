import 'package:cine_zone/repository/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static late SharedPreferences _prefs;

  static Future<void> setToken(String token) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setString(Constant.bearerToken, token);
  }

  static Future<String> getToken() async {
    _prefs = await SharedPreferences.getInstance();
    final currentToken = _prefs.getString(Constant.bearerToken);

    return currentToken ?? '';
  }

  static Future<void> removeToken() async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.remove(Constant.bearerToken);
  }

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
