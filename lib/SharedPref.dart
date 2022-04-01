// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  static read() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(jsonDecode('key'));
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
