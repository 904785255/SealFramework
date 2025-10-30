import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onepartner/data/shared_preferences_db.dart';

const String kAuthPropsStorageKey = 'authProps';

class AuthState extends ChangeNotifier {

  AuthState({required SharedPreferencesDB sharedPreferencesDB})
    : _sharedPreferencesDB = sharedPreferencesDB;

  final SharedPreferencesDB _sharedPreferencesDB;

  Future<void> setAppThemeMode(Map<String, dynamic>? _props) async {
    await _sharedPreferencesDB.sps.setString(SharedPreferencesKey.appThemeMode, jsonEncode(_props));
  }
  Future<Map<String, dynamic>?> getAppThemeMode() async {
    try {
      final stored = await _sharedPreferencesDB.sps.getString(SharedPreferencesKey.appThemeMode);
      if (stored != null) {
        _props = jsonDecode(stored) as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (_) {
    }
    return _props;
  }

  Map<String, dynamic>? _props;
  Map<String, dynamic>? get props => _props;
  bool get isLoggedIn => _props != null;


  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(kAuthPropsStorageKey);
      if (stored != null) {
        _props = jsonDecode(stored) as Map<String, dynamic>;
        notifyListeners();
      }
    } catch (_) {
    }
  }

  Future<void> login(Map<String, dynamic> props) async {
    _props = Map<String, dynamic>.from(props);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kAuthPropsStorageKey, jsonEncode(_props));
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _props = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(kAuthPropsStorageKey);
    } finally {
      notifyListeners();
    }
  }

  dynamic getProp(String key) => _props?[key];

  Future<void> setProp(String key, dynamic value) async {
    _props ??= <String, dynamic>{};
    _props![key] = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kAuthPropsStorageKey, jsonEncode(_props));
    } finally {
      notifyListeners();
    }
  }
}