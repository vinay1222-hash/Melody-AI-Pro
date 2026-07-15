import 'package:flutter/material.dart';
import '../../models/event.dart';
import 'event_members_page.dart';
import 'event_attendance_page.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({
    super.key,
    required this.event,
  });

  Widget detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            detail("Event No", event.eventNumber.toString()),
            detail("Event Name", event.eventName),
            detail("Date", event.date),
            detail("Venue", event.venue),
            detail("Start Time", event.startTime),
            detail("End Time", event.endTime),
            detail("Theme", event.theme),
            detail("Status", event.status),
            detail("Max Performers", event.maxPerformers.toString()),
            detail("Max Guests", event.maxGuests.toString()),
            detail("Remarks", event.remarks),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventMembersPage(event: event),
                    ),
                  );
                },
                child: const Text("Manage Members"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventAttendancePage(event: event),
                    ),
                  );
                },
                child: const Text("Manage Attendance"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
