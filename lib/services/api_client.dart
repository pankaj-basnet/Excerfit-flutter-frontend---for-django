import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ApiClient {
  // static const String baseUrl = 'http://localhost:8000';
  static const String baseUrl = 'http://192.168.1.89:8000';
  final _logger = Logger('ApiClient');
  
  String? _accessToken;
  
  void setToken(String token) {
    _accessToken = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }
    return headers;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access'];
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getDays({int limit = 10, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/days/?limit=$limit&offset=$offset'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load days: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getDay(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/days/$id/'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load day: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateDay(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/days/$id/'),
      headers: _headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update day: ${response.body}');
    }
  }

  Future<void> deleteDay(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/days/$id/'),
      headers: _headers,
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to delete day: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getSlots({int limit = 10, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/slots/?limit=$limit&offset=$offset'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load slots: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getSlot(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/slots/$id/'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load slot: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateSlot(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/slots/$id/'),
      headers: _headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update slot: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getRoutineStructure(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/routines/$id/structure/'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load routine: ${response.body}');
    }
  }
}