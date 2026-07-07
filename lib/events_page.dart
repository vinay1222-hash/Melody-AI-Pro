import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Events"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "🎵 Melody Musical Evening",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            Text("📅 Date : 26 July 2026"),
            SizedBox(height: 10),

            Text("🕔 Time : 5:00 PM - 8:00 PM"),
            SizedBox(height: 10),

            Text("📍 Venue : Kannada Bhavan, Belagavi"),
            SizedBox(height: 30),

            Text(
              "Registered Members",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text("Coming Soon..."),

          ],
        ),
      ),
    );
  }
}