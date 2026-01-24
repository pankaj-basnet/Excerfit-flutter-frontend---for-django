import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';

class AuthProvider with ChangeNotifier {
  final ApiClient _apiClient;
  String? _accessToken;
  String? _refreshToken;
  bool _isAuthenticated = false;

  AuthProvider(this._apiClient);

  bool get isAuthenticated => _isAuthenticated;
  String? get accessToken => _accessToken;

  Future<bool> login(String username, String password) async {
    try {
      final data = await _apiClient.login(username, password);
      _accessToken = data['access'];
      _refreshToken = data['refresh'];
      _isAuthenticated = true;

      // Save tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _accessToken!);
      await prefs.setString('refresh_token', _refreshToken!);

      _apiClient.setToken(_accessToken!);
      notifyListeners();
      return true;
    } catch (e) {
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('access_token')) {
      return false;
    }

    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
    _isAuthenticated = true;
    _apiClient.setToken(_accessToken!);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    notifyListeners();
  }
}