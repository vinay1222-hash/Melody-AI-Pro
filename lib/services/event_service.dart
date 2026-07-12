import '../database/database_helper.dart';
import '../models/event.dart';

class EventService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> addEvent(Event event) async {
    return await _databaseHelper.insertEvent(event);
  }

  Future<List<Event>> getEvents() async {
    return await _databaseHelper.getEvents();
  }

  Future<int> updateEvent(Event event) async {
    return await _databaseHelper.updateEvent(event);
  }

  Future<int> deleteEvent(int id) async {
    return await _databaseHelper.deleteEvent(id);
  }
}