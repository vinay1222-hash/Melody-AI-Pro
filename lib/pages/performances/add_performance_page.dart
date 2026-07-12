import 'package:flutter/material.dart';
import '../../models/performance.dart';
import '../../services/performance_service.dart';
import '../../models/member.dart';
import '../../models/event.dart';
import '../../services/member_service.dart';
import '../../services/event_service.dart';

class AddPerformancePage extends StatefulWidget {
  const AddPerformancePage({super.key});

  @override
  State<AddPerformancePage> createState() => _AddPerformancePageState();
}

class _AddPerformancePageState extends State<AddPerformancePage> {

final _formKey = GlobalKey<FormState>();
final PerformanceService _performanceService = PerformanceService();
final MemberService memberService = MemberService();
final EventService eventService = EventService();

List<Member> members = [];
List<Event> events = [];

Member? selectedMember;
Event? selectedEvent;


@override
void initState() {
  super.initState();
  loadData();
}

Future<void> loadData() async {
  members = await memberService.getMembers();
  events = await eventService.getEvents();

  setState(() {});
}

final TextEditingController songController = TextEditingController();
final TextEditingController movieController = TextEditingController();
final TextEditingController singerController = TextEditingController();
final TextEditingController musicDirectorController = TextEditingController();
final TextEditingController languageController = TextEditingController();
final TextEditingController roundController = TextEditingController();
final TextEditingController orderController = TextEditingController();
final TextEditingController karaokeController = TextEditingController();
final TextEditingController youtubeController = TextEditingController();
final TextEditingController remarksController = TextEditingController();

String performanceType = "Solo";

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Add Performance"),
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: ListView(
children: [
TextFormField(
controller: songController,
decoration: const InputDecoration(
labelText: "Song Name",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: movieController,
decoration: const InputDecoration(
labelText: "Movie Name",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: singerController,
decoration: const InputDecoration(
labelText: "Original Singer",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: musicDirectorController,
decoration: const InputDecoration(
labelText: "Music Director",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: languageController,
decoration: const InputDecoration(
labelText: "Language",
border: OutlineInputBorder(),
),
),
const SizedBox(height: 15),

DropdownButtonFormField<String>(
value: performanceType,
decoration: const InputDecoration(
labelText: "Performance Type",
border: OutlineInputBorder(),
),
items: const [
DropdownMenuItem(value: "Solo", child: Text("Solo")),
DropdownMenuItem(value: "Duet", child: Text("Duet")),
DropdownMenuItem(value: "Group", child: Text("Group")),
],
onChanged: (value) {
setState(() {
performanceType = value!;
});
},
),

const SizedBox(height: 15),

TextFormField(
controller: roundController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: "Round Number",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: orderController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: "Performance Order",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: karaokeController,
decoration: const InputDecoration(
labelText: "Karaoke Link",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: youtubeController,
decoration: const InputDecoration(
labelText: "YouTube Link",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

TextFormField(
controller: remarksController,
maxLines: 3,
decoration: const InputDecoration(
labelText: "Remarks",
border: OutlineInputBorder(),
),
),
const SizedBox(height: 25),

SizedBox(
width: double.infinity,
height: 55,
child: ElevatedButton.icon(
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
        final performance = Performance(
          eventId: selectedEvent?.id ?? 1,
          memberId: selectedMember?.id ?? 1,
          songName: songController.text,
          movieName: movieController.text,
          originalSinger: singerController.text,
          musicDirector: musicDirectorController.text,
          language: languageController.text,
          performanceType: performanceType,
          partnerMemberId: null,
          roundNumber: int.tryParse(roundController.text) ?? 1,
          performanceOrder: int.tryParse(orderController.text) ?? 1,
          karaokeLink: karaokeController.text,
          youtubeLink: youtubeController.text,
          remarks: remarksController.text,
          status: "Active",
        );

        await _performanceService.addPerformance(performance);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Performance Saved Successfully"),
          ),
        );

        Navigator.pop(context);
      }
    },
icon: const Icon(Icons.save),
label: const Text(
"SAVE PERFORMANCE",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
),
),
),
],
),
),
),
);
}
}