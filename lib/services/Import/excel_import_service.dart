import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import 'member_import_service.dart';
import 'event_import_service.dart';

class ExcelImportService {
  Future<int> pickAndReadExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result == null) return 0;

    File file = File(result.files.single.path!);

    var bytes = file.readAsBytesSync();

    Excel excel = Excel.decodeBytes(bytes);

    // Import Members
    final memberImporter = MemberImportService();
    int memberCount = await memberImporter.importMembers(excel);

    // Import Events
    final eventImporter = EventImportService();
    int eventCount = await eventImporter.importEvents(excel);

    print("=================================");
    print("Members Imported : $memberCount");
    print("Events Imported  : $eventCount");
    print("=================================");

    return memberCount;
  }
}