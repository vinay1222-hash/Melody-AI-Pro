import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/member.dart';
import '../models/event.dart';
import '../models/performance.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance =
  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'melody_ai_pro_v2.db');

    return await openDatabase(
      path,
      version: 4,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
  CREATE TABLE IF NOT EXISTS songs(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    songName TEXT,
    movieName TEXT,
    originalSinger TEXT,
    musicDirector TEXT,
    language TEXT,
    karaokeLink TEXT,
    youtubeLink TEXT,
    favorite INTEGER,
    remarks TEXT
  )
  ''');
        await _createEventMembersTable(db);
        await _createEventAttendanceTable(db);
      },
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE members(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        mobile TEXT,
        email TEXT,
        city TEXT,
        gender TEXT,
        membership TEXT
      )
    ''');
    await db.execute('''
CREATE TABLE events(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  eventName TEXT,
  eventNumber INTEGER,
  date TEXT,
  venue TEXT,
  startTime TEXT,
  endTime TEXT,
  theme TEXT,
  maxPerformers INTEGER,
  maxGuests INTEGER,
  status TEXT,
  remarks TEXT
)
''');
    await db.execute('''
CREATE TABLE performances(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  eventId INTEGER,
  memberId INTEGER,
  songName TEXT,
  movieName TEXT,
  originalSinger TEXT,
  musicDirector TEXT,
  language TEXT,
  performanceType TEXT,
  partnerMemberId INTEGER,
  roundNumber INTEGER,
  performanceOrder INTEGER,
  karaokeLink TEXT,
  youtubeLink TEXT,
  remarks TEXT,
  status TEXT
)
''');
    await db.execute('''
CREATE TABLE songs(
id INTEGER PRIMARY KEY AUTOINCREMENT,
songName TEXT,
movieName TEXT,
originalSinger TEXT,
musicDirector TEXT,
language TEXT,
karaokeLink TEXT,
youtubeLink TEXT,
favorite INTEGER,
remarks TEXT
)
''');
    await _createEventMembersTable(db);
    await _createEventAttendanceTable(db);
  }

  Future<void> _createEventMembersTable(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS event_members(
id INTEGER PRIMARY KEY AUTOINCREMENT,
eventId INTEGER NOT NULL,
memberId INTEGER NOT NULL
)
''');
  }

  Future<void> _createEventAttendanceTable(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS event_attendance(
id INTEGER PRIMARY KEY AUTOINCREMENT,
eventId INTEGER NOT NULL,
memberId INTEGER NOT NULL,
present INTEGER NOT NULL,
guestCount INTEGER NOT NULL
)
''');
  }


  // Insert Member
  Future<int> insertMember(Member member) async {
    final db = await database;

    final existing = await db.query(
      'members',
      where: 'name = ? AND mobile = ?',
      whereArgs: [
        member.name,
        member.mobile,
      ],
    );

    if (existing.isNotEmpty) {
      return 0;
    }

    return await db.insert(
      'members',
      member.toMap(),
    );
  }

  // Get All Members
  Future<List<Member>> getMembers() async {
    final db = await database;

    final result = await db.query(
      'members',
      orderBy: 'name ASC',
    );

    return result.map((e) => Member.fromMap(e)).toList();
  }

  // Update Member
  Future<int> updateMember(Member member) async {
    final db = await database;

    return await db.update(
      'members',
      member.toMap(),
      where: 'id = ?',
      whereArgs: [member.id],
    );
  }

  // Delete Member
  Future<int> deleteMember(int id) async {
    final db = await database;

    return await db.delete(
      'members',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
// Insert Event
  Future<int> insertEvent(Event event) async {
    final db = await database;

    return await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Get All Events
  Future<List<Event>> getEvents() async {
    final db = await database;

    final result = await db.query(
      'events',
      orderBy: 'eventNumber DESC',
    );

    return result.map((e) => Event.fromMap(e)).toList();
  }

// Update Event
  Future<int> updateEvent(Event event) async {
    final db = await database;

    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

// Delete Event
  Future<int> deleteEvent(int id) async {
    final db = await database;

    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Get Event Member IDs
  Future<List<int>> getEventMemberIds(int eventId) async {
    final db = await database;

    final result = await db.query(
      'event_members',
      columns: ['memberId'],
      where: 'eventId = ?',
      whereArgs: [eventId],
    );

    return result.map((e) => e['memberId'] as int).toList();
  }

// Save Event Members
  Future<void> saveEventMembers(
    int eventId,
    List<int> memberIds,
  ) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete(
        'event_members',
        where: 'eventId = ?',
        whereArgs: [eventId],
      );

      for (final memberId in memberIds) {
        await txn.insert(
          'event_members',
          {
            'eventId': eventId,
            'memberId': memberId,
          },
        );
      }
    });
  }

// Get Event Attendance
  Future<List<Map<String, dynamic>>> getEventAttendance(int eventId) async {
    final db = await database;

    return await db.query(
      'event_attendance',
      where: 'eventId = ?',
      whereArgs: [eventId],
    );
  }

// Save Event Attendance
  Future<void> saveEventAttendance(
    int eventId,
    List<Map<String, dynamic>> attendanceRows,
  ) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete(
        'event_attendance',
        where: 'eventId = ?',
        whereArgs: [eventId],
      );

      for (final row in attendanceRows) {
        await txn.insert(
          'event_attendance',
          {
            'eventId': eventId,
            'memberId': row['memberId'],
            'present': row['present'],
            'guestCount': row['guestCount'],
          },
        );
      }
    });
  }
  // Insert Performance
  Future<int> insertPerformance(Performance performance) async {
    final db = await database;

    return await db.insert(
      'performances',
      performance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Get All Performances
  Future<List<Performance>> getPerformances() async {
    final db = await database;

    final result = await db.query(
      'performances',
      orderBy: 'id DESC',
    );

    return result.map((e) => Performance.fromMap(e)).toList();
  }

// Update Performance
  Future<int> updatePerformance(Performance performance) async {
    final db = await database;

    return await db.update(
      'performances',
      performance.toMap(),
      where: 'id = ?',
      whereArgs: [performance.id],
    );
  }

// Delete Performance
  Future<int> deletePerformance(int id) async {
    final db = await database;

    return await db.delete(
      'performances',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Close Database
  Future close() async {
    final db = await database;
    db.close();
  }
}
