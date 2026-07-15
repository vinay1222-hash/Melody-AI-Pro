import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/event.dart';
import '../../models/member.dart';
import '../../services/member_service.dart';

class EventMembersPage extends StatefulWidget {
  final Event event;

  const EventMembersPage({
    super.key,
    required this.event,
  });

  @override
  State<EventMembersPage> createState() => _EventMembersPageState();
}

class _EventMembersPageState extends State<EventMembersPage> {
  final MemberService _memberService = MemberService();

  List<Member> members = [];
  Set<int> selectedMemberIds = {};

  List<Member> get activeMembers => members
      .where((member) => member.membership.toLowerCase() != "inactive")
      .toList();

  int get selectedActiveMemberCount => activeMembers
      .where((member) =>
          member.id != null && selectedMemberIds.contains(member.id))
      .length;
  bool loading = true;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    loadMembers();
  }

  Future<void> loadMembers() async {
    final loadedMembers = await _memberService.getMembers();
    final eventMemberIds = await DatabaseHelper.instance.getEventMemberIds(
      widget.event.id!,
    );

    setState(() {
      members = loadedMembers;
      selectedMemberIds = eventMemberIds.toSet();
      loading = false;
    });
  }

  Future<void> saveMembers() async {
    setState(() {
      saving = true;
    });

    await DatabaseHelper.instance.saveEventMembers(
      widget.event.id!,
      selectedMemberIds.toList(),
    );

    if (mounted) {
      setState(() {
        saving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Members assigned successfully."),
        ),
      );
    }
  }

  void toggleMember(Member member, bool? selected) {
    if (member.id == null) return;

    setState(() {
      if (selected == true) {
        selectedMemberIds.add(member.id!);
      } else {
        selectedMemberIds.remove(member.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Members"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : activeMembers.isEmpty
              ? const Center(child: Text("No Active Members Found"))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Selected Members: $selectedActiveMemberCount",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: activeMembers.length,
                        itemBuilder: (context, index) {
                          final member = activeMembers[index];
                          final selected = member.id != null &&
                              selectedMemberIds.contains(member.id);

                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: selected,
                            onChanged: (value) => toggleMember(member, value),
                            title: Text(member.name),
                            subtitle: Text(member.mobile),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: saving ? null : saveMembers,
        icon: const Icon(Icons.save),
        label: Text(saving ? "Saving..." : "Save Members"),
      ),
    );
  }
}
