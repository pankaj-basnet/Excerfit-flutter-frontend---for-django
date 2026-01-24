import 'package:flutter/foundation.dart';
import '../models/routine.dart';
import '../services/api_client.dart';

class RoutineProvider with ChangeNotifier {
  final ApiClient _apiClient;
  Routine? _currentRoutine;
  bool _isLoading = false;

  RoutineProvider(this._apiClient);

  Routine? get currentRoutine => _currentRoutine;
  bool get isLoading => _isLoading;

  Future<void> fetchRoutine(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiClient.getRoutineStructure(id);
      _currentRoutine = Routine.fromJson(response);
    } catch (e) {
      print('Error fetching routine: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearRoutine() {
    _currentRoutine = null;
    notifyListeners();
  }
}