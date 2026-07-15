import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/event.dart';
import '../../models/member.dart';
import '../../services/member_service.dart';

class EventAttendancePage extends StatefulWidget {
  final Event event;

  const EventAttendancePage({
    super.key,
    required this.event,
  });

  @override
  State<EventAttendancePage> createState() => _EventAttendancePageState();
}

class _EventAttendancePageState extends State<EventAttendancePage> {
  final MemberService _memberService = MemberService();

  List<Member> selectedMembers = [];
  Map<int, bool> presentMembers = {};
  Map<int, int> guestCounts = {};
  bool loading = true;
  bool saving = false;

  int get presentMemberCount =>
      presentMembers.values.where((present) => present).length;

  int get totalGuests =>
      guestCounts.values.fold(0, (total, guests) => total + guests);

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {
    final allMembers = await _memberService.getMembers();
    final eventMemberIds = await DatabaseHelper.instance.getEventMemberIds(
      widget.event.id!,
    );
    final savedAttendance = await DatabaseHelper.instance.getEventAttendance(
      widget.event.id!,
    );

    final eventMemberSet = eventMemberIds.toSet();
    final attendanceByMemberId = {
      for (final attendance in savedAttendance)
        attendance['memberId'] as int: attendance,
    };

    setState(() {
      selectedMembers = allMembers
          .where((member) =>
              member.id != null && eventMemberSet.contains(member.id))
          .toList();

      presentMembers = {
        for (final member in selectedMembers)
          member.id!: attendanceByMemberId[member.id]?['present'] == 1,
      };

      guestCounts = {
        for (final member in selectedMembers)
          member.id!: attendanceByMemberId[member.id]?['guestCount'] as int? ?? 0,
      };

      loading = false;
    });
  }

  Future<void> saveAttendance() async {
    setState(() {
      saving = true;
    });

    final attendanceRows = selectedMembers
        .where((member) => member.id != null)
        .map(
          (member) => {
            'memberId': member.id!,
            'present': presentMembers[member.id] == true ? 1 : 0,
            'guestCount': guestCounts[member.id] ?? 0,
          },
        )
        .toList();

    await DatabaseHelper.instance.saveEventAttendance(
      widget.event.id!,
      attendanceRows,
    );

    if (mounted) {
      setState(() {
        saving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Attendance saved successfully."),
        ),
      );
    }
  }

  Widget summaryCard(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget memberRow(Member member) {
    final memberId = member.id!;

    return Card(
      child: ListTile(
        leading: Checkbox(
          value: presentMembers[memberId] ?? false,
          onChanged: (value) {
            setState(() {
              presentMembers[memberId] = value ?? false;
            });
          },
        ),
        title: Text(member.name),
        subtitle: Text(member.mobile),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: (guestCounts[memberId] ?? 0) == 0
                  ? null
                  : () {
                      setState(() {
                        guestCounts[memberId] =
                            (guestCounts[memberId] ?? 0) - 1;
                      });
                    },
            ),
            Text((guestCounts[memberId] ?? 0).toString()),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: (guestCounts[memberId] ?? 0) == 10
                  ? null
                  : () {
                      setState(() {
                        guestCounts[memberId] =
                            (guestCounts[memberId] ?? 0) + 1;
                      });
                    },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Attendance"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : selectedMembers.isEmpty
              ? const Center(child: Text("No Members Selected For This Event"))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          summaryCard(
                            "Selected Members",
                            selectedMembers.length.toString(),
                          ),
                          summaryCard(
                            "Present Members",
                            presentMemberCount.toString(),
                          ),
                          summaryCard(
                            "Total Guests",
                            totalGuests.toString(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: selectedMembers.length,
                        itemBuilder: (context, index) {
                          return memberRow(selectedMembers[index]);
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: saving ? null : saveAttendance,
        icon: const Icon(Icons.save),
        label: Text(saving ? "Saving..." : "Save Attendance"),
      ),
    );
  }
}
