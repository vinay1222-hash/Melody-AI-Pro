import 'package:flutter/material.dart';

import '../../services/import/excel_import_service.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  final ExcelImportService _importService = ExcelImportService();

  bool importing = false;

  Future<void> startImport() async {
    setState(() {
      importing = true;
    });

    try {
      int imported = await _importService.pickAndReadExcel();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "$imported members imported successfully",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }

    setState(() {
      importing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel Import"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: importing
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: const Text("Select Excel File"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
          onPressed: startImport,
        ),
      ),
    );
  }
}