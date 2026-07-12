import 'package:excel/excel.dart';

import '../../database/database_helper.dart';
import '../../models/event.dart';

class EventImportService {
  Future<int> importEvents(Excel excel) async {
    Sheet? sheet = excel.tables["Stats"];

    if (sheet == null) {
      print("Stats sheet not found.");
      return 0;
    }

    // Clear old imported events
    final db = await DatabaseHelper.instance.database;
    await db.delete("events");

    int imported = 0;

    // Start from row 5 (Excel row 5 = index 4)
    for (int i = 4; i < sheet.rows.length; i++) {
      var row = sheet.rows[i];

      if (row.isEmpty) continue;
      if (row[0]?.value == null) continue;

      String eventName = row[0]?.value.toString() ?? "";

      // Extract event number from "19th Event"
      int eventNumber = int.tryParse(
        eventName.replaceAll(RegExp(r'[^0-9]'), ''),
      ) ??
          0;

      Event event = Event(
        eventName: eventName,
        eventNumber: eventNumber,
        date: row.length > 2 ? row[2]?.value.toString() ?? "" : "",
        venue: row.length > 1 ? row[1]?.value.toString() ?? "" : "",
        startTime: row.length > 3 ? row[3]?.value.toString() ?? "" : "",
        endTime: row.length > 4 ? row[4]?.value.toString() ?? "" : "",
        theme: "Melody Event",
        maxPerformers:
        row.length > 6 ? int.tryParse(row[6]?.value.toString() ?? "0") ?? 0 : 0,
        maxGuests: 0,
        status: "Completed",
        remarks: "",
      );

      await DatabaseHelper.instance.insertEvent(event);

      imported++;
      print("Imported: $eventName");
    }

    print("===============================");
    print("Events Imported : $imported");
    print("===============================");

    return imported;
  }
}