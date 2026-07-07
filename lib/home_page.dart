import 'package:flutter/material.dart';
import 'members_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "Members", "icon": Icons.group},
      {"title": "Singers", "icon": Icons.mic},
      {"title": "Songs", "icon": Icons.music_note},
      {"title": "Events", "icon": Icons.event},
      {"title": "Playlist", "icon": Icons.queue_music},
      {"title": "Karaoke", "icon": Icons.library_music},
      {"title": "Payments", "icon": Icons.payments},
      {"title": "Reports", "icon": Icons.bar_chart},
      {"title": "Melody AI", "icon": Icons.smart_toy},
      {"title": "Settings", "icon": Icons.settings},
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
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${menuItems[index]["title"]} module coming next...",
                          ),
                        ),
                      );
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
                            size: 45,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            menuItems[index]["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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