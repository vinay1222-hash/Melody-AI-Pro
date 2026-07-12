import 'package:flutter/material.dart';

import 'members/members_list_page.dart';
import 'events/events_list_page.dart';
import 'performances/performance_list_page.dart';
import 'songs/song_list_page.dart';
import '../services/Import/import_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "Members", "icon": Icons.group},
      {"title": "Singers", "icon": Icons.mic},
      {"title": "Performances", "icon": Icons.music_note},
      {"title": "Songs", "icon": Icons.library_music},
      {"title": "Events", "icon": Icons.event},
      {"title": "Playlist", "icon": Icons.queue_music},
      {"title": "Karaoke", "icon": Icons.music_video},
      {"title": "Payments", "icon": Icons.payments},
      {"title": "Reports", "icon": Icons.bar_chart},
      {"title": "Melody AI", "icon": Icons.smart_toy},
      {"title": "Settings", "icon": Icons.settings},
      {"title": "Excel Import", "icon": Icons.upload_file},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Melody AI Pro"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Vinayak 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Manage your music club from one place.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      if (menuItems[index]["title"] == "Members") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MembersListPage(),
                          ),
                        );
                      } else if (menuItems[index]["title"] ==
                          "Performances") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const PerformanceListPage(),
                          ),
                        );
                      } else if (menuItems[index]["title"] == "Songs") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SongListPage(),
                          ),
                        );
                      } else if (menuItems[index]["title"] == "Events") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EventsListPage(),
                          ),
                          );
                            }
                      else if (menuItems[index]["title"] == "Excel Import") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ImportPage(),
                          ),
                        );

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${menuItems[index]["title"]} module coming soon!",
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            menuItems[index]["icon"],
                            size: 34,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            menuItems[index]["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}