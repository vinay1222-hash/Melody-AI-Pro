import 'package:flutter/material.dart';

import '../../models/song.dart';

class SongDetailsPage extends StatelessWidget {
  final Song song;

  const SongDetailsPage({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Song Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.music_note),
              title: const Text("Song"),
              subtitle: Text(song.songName),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text("Movie"),
              subtitle: Text(song.movieName),
            ),
            ListTile(
              leading: const Icon(Icons.mic),
              title: const Text("Original Singer"),
              subtitle: Text(song.originalSinger),
            ),
            ListTile(
              leading: const Icon(Icons.library_music),
              title: const Text("Music Director"),
              subtitle: Text(song.musicDirector),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Language"),
              subtitle: Text(song.language),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favorite"),
              subtitle: Text(song.favorite ? "Yes" : "No"),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("Remarks"),
              subtitle: Text(song.remarks),
            ),
          ],
        ),
      ),
    );
  }
}