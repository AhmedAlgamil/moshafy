import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefrence {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setBool(String key, bool value) async {
    return await sharedPreferences?.setBool(key, value);
  }

  static Future<bool?> remove(String key,) async {
    return await sharedPreferences?.remove(key);
  }

  static Future<bool?> setString(String key, String? value) async {
    return await sharedPreferences?.setString(key, value!);
  }

  static Future<bool?> setInt(String key, int? value) async {
    return await sharedPreferences?.setInt(key, value!);
  }

  static get(String key) {
    return sharedPreferences?.get(
      key,
    );
  }
}
