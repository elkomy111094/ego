import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart' as e;
/* Define Shared prefrence Singleton Pattern */

class SharedPrefs {
  SharedPrefs._();
  static Future<e.SharedPreferences> get _instance async =>
      _prefsInstance = await e.SharedPreferences.getInstance();
  static e.SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<e.SharedPreferences?> initialize() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance!.getInt(key) ?? defValue ?? 0;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static double getDouble(String key, [double? defValue]) {
    return _prefsInstance!.getDouble(key) ?? defValue ?? 0.0;
  }

  static Future<bool> setDouble(String? key, double? value) async {
    var prefs = await _instance;
    return prefs.setDouble(key!, value!);
  }

  static Future<void> clear() async {
    var prefs = await _instance;
    prefs.clear();
  }

  static Future<void> reload() async {
    var prefs = await _instance;
    prefs.reload();
  }

  Future<void> put(String key, dynamic value) async {
    var prefs = await _instance;
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }
}
