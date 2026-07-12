import '../database/database_helper.dart';
import '../models/performance.dart';

class PerformanceService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> addPerformance(Performance performance) async {
    return await _databaseHelper.insertPerformance(performance);
  }

  Future<List<Performance>> getPerformances() async {
    return await _databaseHelper.getPerformances();
  }

  Future<int> updatePerformance(Performance performance) async {
    return await _databaseHelper.updatePerformance(performance);
  }

  Future<int> deletePerformance(int id) async {
    return await _databaseHelper.deletePerformance(id);
  }
}