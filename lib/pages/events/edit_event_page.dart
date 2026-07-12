import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';

class EditEventPage extends StatefulWidget {
  final Event event;

  const EditEventPage({
    super.key,
    required this.event,
  });

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final EventService _eventService = EventService();

  late TextEditingController eventNumberController;
  late TextEditingController eventNameController;
  late TextEditingController dateController;
  late TextEditingController venueController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController themeController;
  late TextEditingController remarksController;

  String status = "Upcoming";

  @override
  void initState() {
    super.initState();

    eventNumberController =
        TextEditingController(text: widget.event.eventNumber.toString());

    eventNameController =
        TextEditingController(text: widget.event.eventName);

    dateController =
        TextEditingController(text: widget.event.date);

    venueController =
        TextEditingController(text: widget.event.venue);

    startTimeController =
        TextEditingController(text: widget.event.startTime);

    endTimeController =
        TextEditingController(text: widget.event.endTime);

    themeController =
        TextEditingController(text: widget.event.theme);

    remarksController =
        TextEditingController(text: widget.event.remarks);

    status = widget.event.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Edit page created successfully.\nNext we will add the form.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}