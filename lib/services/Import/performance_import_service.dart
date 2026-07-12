import 'package:excel/excel.dart';

class PerformanceImportService {

  Future<int> importPerformances(Excel excel) async {

    int imported = 0;

    for (String sheetName in excel.tables.keys) {

      if (!sheetName.toLowerCase().startsWith("event")) {
        continue;
      }

      print("Importing $sheetName");

      Sheet? sheet = excel.tables[sheetName];

      if (sheet == null) continue;

      // We will import rows in the next step.

      imported++;
    }

    return imported;
  }
}