import 'package:flutter/material.dart';

import '../../models/performance.dart';
import '../../services/performance_service.dart';
import 'add_performance_page.dart';
import 'performance_details_page.dart';
import 'edit_performance_page.dart';

class PerformanceListPage extends StatefulWidget {
  const PerformanceListPage({super.key});

  @override
  State<PerformanceListPage> createState() =>
      _PerformanceListPageState();
}

class _PerformanceListPageState
    extends State<PerformanceListPage> {

  final PerformanceService _performanceService =
  PerformanceService();

  List<Performance> performances = [];

  @override
  void initState() {
    super.initState();
    loadPerformances();
  }

  Future<void> loadPerformances() async {
    performances =
    await _performanceService.getPerformances();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Performance History"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: performances.isEmpty
          ? const Center(
        child: Text(
          "No Performance Found",
        ),
      )

          : ListView.builder(
        itemCount: performances.length,
        itemBuilder: (context, index) {

          final performance =
          performances[index];

          return Card(
            margin:
            const EdgeInsets.all(8),

            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),

              title: Text(performance.songName),

              subtitle: Text(
                "${performance.performanceType} • ${performance.language}",
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerformanceDetailsPage(
                      performance: performance,
                    ),
                  ),
                );
              },

              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditPerformancePage(
                          performance: performance,
                        ),
                      ),
                    );
                    loadPerformances();
                  } else if (value == "delete") {
                    await _performanceService.deletePerformance(
                      performance.id!,
                    );
                    loadPerformances();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: "edit",
                    child: Text("Edit"),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),


          );
        },
      ),

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        Colors.deepPurple,

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddPerformancePage(),
            ),
          );

          loadPerformances();

        },
      ),
    );
  }
}