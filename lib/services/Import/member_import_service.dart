import 'package:excel/excel.dart';

import '../../database/database_helper.dart';
import '../../models/member.dart';

class MemberImportService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> importMembers(Excel excel) async {
    // Your master workbook sheet name
    final sheet = excel.tables['Master Sheet'];

    if (sheet == null) {
      throw Exception("Master Sheet not found.");
    }

    if (sheet.rows.length < 3) {
      throw Exception("No member data found.");
    }

    // Header is on row index 1 (Excel row 2)
    final headers = sheet.rows[1]
        .map((e) => e?.value.toString().trim() ?? "")
        .toList();

    int getColumn(String header) {
      return headers.indexWhere(
            (h) => h.toLowerCase() == header.toLowerCase(),
      );
    }

    final nameCol = getColumn("Name");
    final mobileCol = getColumn("Ph.No");
    final cityCol = getColumn("Place");
    final genderCol = getColumn("Gender");
    final membershipCol = getColumn("Catogory");

    if (nameCol == -1) {
      throw Exception("Name column not found.");
    }

    int imported = 0;

    // Data starts from Excel row 3 (index 2)
    for (int i = 2; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];

      String read(int col) {
        if (col < 0) return "";
        if (col >= row.length) return "";
        return row[col]?.value?.toString().trim() ?? "";
      }

      final name = read(nameCol);

      if (name.isEmpty) {
        continue;
      }

      Member member = Member(
        name: name,
        mobile: read(mobileCol),
        email: "",
        city: read(cityCol),
        gender: read(genderCol),
        membership: read(membershipCol),
      );

      await _databaseHelper.insertMember(member);
      imported++;
    }

    return imported;
  }
}