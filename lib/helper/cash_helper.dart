import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;
  static late SharedPreferences sharedPreferences;
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future saveToken(String token) async {
    await _prefs?.setString('token', token);
  }

  static String? getToken() {
    return _prefs?.getString('token');
  }

  static Future clearToken() async {
    await _prefs?.remove('token');
  }
  static String? getUserName() {
    return sharedPreferences.getString("userName");
  }
}