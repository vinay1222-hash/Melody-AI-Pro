import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final EventService _eventService = EventService();

  final eventNameController = TextEditingController();
  final eventNumberController = TextEditingController();
  final dateController = TextEditingController();
  final venueController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final themeController = TextEditingController();
  final remarksController = TextEditingController();

  String status = "Upcoming";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Event"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: eventNumberController,
                decoration: const InputDecoration(labelText: "Event Number"),
              ),

              TextFormField(
                controller: eventNameController,
                decoration: const InputDecoration(labelText: "Event Name"),
              ),

              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Date"),
              ),

              TextFormField(
                controller: venueController,
                decoration: const InputDecoration(labelText: "Venue"),
              ),

              TextFormField(
                controller: startTimeController,
                decoration: const InputDecoration(labelText: "Start Time"),
              ),

              TextFormField(
                controller: endTimeController,
                decoration: const InputDecoration(labelText: "End Time"),
              ),

              TextFormField(
                controller: themeController,
                decoration: const InputDecoration(labelText: "Theme"),
              ),

              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(
                      value: "Upcoming", child: Text("Upcoming")),
                  DropdownMenuItem(
                      value: "Completed", child: Text("Completed")),
                ],
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
              ),

              TextFormField(
                controller: remarksController,
                decoration: const InputDecoration(labelText: "Remarks"),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () async {
                  Event event = Event(
                    eventName: eventNameController.text,
                    eventNumber: int.tryParse(eventNumberController.text) ?? 0,
                    date: dateController.text,
                    venue: venueController.text,
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    theme: themeController.text,
                    maxPerformers: 50,
                    maxGuests: 100,
                    status: status,
                    remarks: remarksController.text,
                  );

                  await _eventService.addEvent(event);

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("SAVE EVENT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}