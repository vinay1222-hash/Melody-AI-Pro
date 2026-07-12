import 'package:flutter/material.dart';
import '../../models/performance.dart';

class PerformanceDetailsPage extends StatelessWidget {
  final Performance performance;

  const PerformanceDetailsPage({
    super.key,
    required this.performance,
  });

  Widget buildTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        title: Text(title),
        subtitle: Text(value.isEmpty ? "-" : value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          buildTile(
            Icons.music_note,
            "Song Name",
            performance.songName,
          ),

          buildTile(
            Icons.movie,
            "Movie Name",
            performance.movieName,
          ),

          buildTile(
            Icons.mic,
            "Original Singer",
            performance.originalSinger,
          ),

          buildTile(
            Icons.library_music,
            "Music Director",
            performance.musicDirector,
          ),

          buildTile(
            Icons.language,
            "Language",
            performance.language,
          ),

          buildTile(
            Icons.people,
            "Performance Type",
            performance.performanceType,
          ),

          buildTile(
            Icons.looks_one,
            "Round Number",
            performance.roundNumber.toString(),
          ),

          buildTile(
            Icons.format_list_numbered,
            "Performance Order",
            performance.performanceOrder.toString(),
          ),

          buildTile(
            Icons.link,
            "Karaoke Link",
            performance.karaokeLink,
          ),

          buildTile(
            Icons.play_circle_fill,
            "YouTube Link",
            performance.youtubeLink,
          ),

          buildTile(
            Icons.note,
            "Remarks",
            performance.remarks,
          ),

          buildTile(
            Icons.verified,
            "Status",
            performance.status,
          ),
        ],
      ),
    );
  }
}