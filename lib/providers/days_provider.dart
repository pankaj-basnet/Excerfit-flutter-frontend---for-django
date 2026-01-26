import 'package:flutter/foundation.dart';
import '../models/day.dart';
import '../services/api_client.dart';

class DaysProvider with ChangeNotifier {
  final ApiClient _apiClient;
  List<Day> _days = [];
  bool _isLoading = false;
  int _totalCount = 0;

  DaysProvider(this._apiClient);

  List<Day> get days => [..._days];
  bool get isLoading => _isLoading;
  int get totalCount => _totalCount;

  Future<void> fetchDays({int limit = 10, int offset = 0}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiClient.getDays(limit: limit, offset: offset);
      _totalCount = response['count'];
      _days = (response['results'] as List)
          .map((day) => Day.fromJson(day))
          .toList();
    } catch (e) {
      print('Error fetching days: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Day?> fetchDay(int id) async {
    try {
      final response = await _apiClient.getDay(id);
      return Day.fromJson(response);
    } catch (e) {
      print('Error fetching day: $e');
      return null;
    }
  }

  Future<void> updateDay(int id, int order, String typeOf) async {
    try {
      await _apiClient.updateDay(id, {
        'order': order,
        'type_of': typeOf,
      });
      await fetchDays();
    } catch (e) {
      print('Error updating day: $e');
      rethrow;
    }
  }

  Future<void> deleteDay(int id) async {
    try {
      await _apiClient.deleteDay(id);
      _days.removeWhere((day) => day.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting day: $e');
      rethrow;
    }
  }

  Day? findById(int id) {
    try {
      return _days.firstWhere((day) => day.id == id);
    } catch (e) {
      return null;
    }
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\providers\days_provider.dart
