import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';
import 'add_event_page.dart';
import 'event_details_page.dart';
import 'edit_event_page.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  final EventService _eventService = EventService();

  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    events = await _eventService.getEvents();
    setState(() {});
  }

  Color statusColor(String status) {
    return status == "Completed"
        ? Colors.green
        : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Melody Events"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: events.isEmpty
          ? const Center(
        child: Text(
          "No Events Found",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: events.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final event = events[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailsPage(event: event),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  event.eventNumber.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              title: Text(
                event.eventName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.date),
                  Text(event.venue),
                  const SizedBox(height: 5),
                  Chip(
                    label: Text(event.status),
                    backgroundColor:
                    statusColor(event.status),
                  ),
                ],
              ),

              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditEventPage(event: event),
                      ),
                    );
                    loadEvents();
                  }

                  if (value == "delete") {
                    if (event.id != null) {
                      await _eventService.deleteEvent(event.id!);
                      loadEvents();
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "edit",
                    child: Text("Edit"),
                  ),
                  const PopupMenuItem(
                    value: "delete",
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEventPage(),
            ),
          );

          loadEvents();
        },
      ),
    );
  }
}