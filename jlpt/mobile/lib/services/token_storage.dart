import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

/// Persists the current session (tokens + user + selected level) to
/// SharedPreferences, mirroring the frontend's localStorage-backed auth store.
class TokenStorage {
  static const _accessTokenKey = 'jlpt.accessToken';
  static const _refreshTokenKey = 'jlpt.refreshToken';
  static const _userKey = 'jlpt.user';
  static const _selectedLevelKey = 'jlpt.selectedLevel';

  Future<void> saveSession(String accessToken, String refreshToken, AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userKey);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<AppUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return AppUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<String> getSelectedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedLevelKey) ?? 'N5';
  }

  Future<void> setSelectedLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLevelKey, level);
  }
}
