import 'package:flutter/material.dart';

import '../../models/performance.dart';
import '../../services/performance_service.dart';

class EditPerformancePage extends StatefulWidget {
  final Performance performance;

  const EditPerformancePage({
    super.key,
    required this.performance,
  });

  @override
  State<EditPerformancePage> createState() =>
      _EditPerformancePageState();
}

class _EditPerformancePageState extends State<EditPerformancePage> {
  final PerformanceService _performanceService = PerformanceService();

  late TextEditingController songController;
  late TextEditingController movieController;
  late TextEditingController singerController;
  late TextEditingController musicDirectorController;
  late TextEditingController languageController;
  late TextEditingController roundController;
  late TextEditingController orderController;
  late TextEditingController karaokeController;
  late TextEditingController youtubeController;
  late TextEditingController remarksController;

  late String performanceType;

  @override
  void initState() {
    super.initState();

    songController =
        TextEditingController(text: widget.performance.songName);

    movieController =
        TextEditingController(text: widget.performance.movieName);

    singerController =
        TextEditingController(text: widget.performance.originalSinger);

    musicDirectorController =
        TextEditingController(text: widget.performance.musicDirector);

    languageController =
        TextEditingController(text: widget.performance.language);

    roundController =
        TextEditingController(text: widget.performance.roundNumber.toString());

    orderController =
        TextEditingController(text: widget.performance.performanceOrder.toString());

    karaokeController =
        TextEditingController(text: widget.performance.karaokeLink);

    youtubeController =
        TextEditingController(text: widget.performance.youtubeLink);

    remarksController =
        TextEditingController(text: widget.performance.remarks);

    performanceType = widget.performance.performanceType;
  }

  @override
  void dispose() {
    songController.dispose();
    movieController.dispose();
    singerController.dispose();
    musicDirectorController.dispose();
    languageController.dispose();
    roundController.dispose();
    orderController.dispose();
    karaokeController.dispose();
    youtubeController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  Future<void> updatePerformance() async {
    final updatedPerformance = Performance(
      id: widget.performance.id,
      eventId: widget.performance.eventId,
      memberId: widget.performance.memberId,
      songName: songController.text,
      movieName: movieController.text,
      originalSinger: singerController.text,
      musicDirector: musicDirectorController.text,
      language: languageController.text,
      performanceType: performanceType,
      partnerMemberId: widget.performance.partnerMemberId,
      roundNumber: int.tryParse(roundController.text) ?? 1,
      performanceOrder: int.tryParse(orderController.text) ?? 1,
      karaokeLink: karaokeController.text,
      youtubeLink: youtubeController.text,
      remarks: remarksController.text,
      status: widget.performance.status,
    );

    await _performanceService.updatePerformance(updatedPerformance);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Performance Updated Successfully"),
      ),
    );

    Navigator.pop(context, true);
  }

  Widget buildField(TextEditingController controller, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Performance"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildField(songController, "Song Name"),
            buildField(movieController, "Movie Name"),
            buildField(singerController, "Original Singer"),
            buildField(musicDirectorController, "Music Director"),
            buildField(languageController, "Language"),

            DropdownButtonFormField<String>(
              value: performanceType,
              decoration: const InputDecoration(
                labelText: "Performance Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Solo", child: Text("Solo")),
                DropdownMenuItem(value: "Duet", child: Text("Duet")),
                DropdownMenuItem(value: "Group", child: Text("Group")),
              ],
              onChanged: (value) {
                setState(() {
                  performanceType = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            buildField(roundController, "Round Number",
                keyboard: TextInputType.number),

            buildField(orderController, "Performance Order",
                keyboard: TextInputType.number),

            buildField(karaokeController, "Karaoke Link"),
            buildField(youtubeController, "YouTube Link"),
            buildField(remarksController, "Remarks"),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: updatePerformance,
                icon: const Icon(Icons.save),
                label: const Text(
                  "UPDATE PERFORMANCE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}