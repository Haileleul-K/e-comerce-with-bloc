import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance ??=  LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<Map<String, dynamic>> read(String key) async {
    return await json.decode(_preferences?.getString(key) ?? '') as Map<String, dynamic> ;
  }

  save(String key, dynamic value) async {
    await _preferences?.setString(key, json.encode(value));
  }

  remove(String key) async {
    await _preferences?.remove(key);
  }

  void clearData() async {
    await _preferences!.clear();
  }

  String get getToken {
    var token = _getFromDisk("token");
    if (token == null) {
      return "";
    }
    return token;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    return value;
  }

  saveStringToDisk(String key, String content) {
    _preferences!.setString(key, content);
  }

  saveBooleanToDisk(String key, bool content) async {
    await  _preferences?.setBool(key, content);
  }

  Future<bool> isLogin(String key) async {
    var value = _preferences!.getBool(key);
    return value ?? false;
  }

  Future<String?> getStringFromDisk(String key) async {
    var value = _preferences!.getString(key);
    return value;
  }

}
