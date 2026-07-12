import 'package:flutter/material.dart';

import '../../models/song.dart';

class EditSongPage extends StatelessWidget {
  final Song song;

  const EditSongPage({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Song"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Edit Song: ${song.songName}\n\nComing Soon",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}