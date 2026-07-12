import 'package:flutter/material.dart';

import '../../models/member.dart';
import '../../services/member_service.dart';
import 'add_member_page.dart';
import 'member_details_page.dart';

class MembersListPage extends StatefulWidget {
  const MembersListPage({super.key});

  @override
  State<MembersListPage> createState() => _MembersListPageState();
}

class _MembersListPageState extends State<MembersListPage> {
  final MemberService _memberService = MemberService();

  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    loadMembers();
  }

  Future<void> loadMembers() async {
    members = await _memberService.getMembers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: members.isEmpty
          ? const Center(
        child: Text("No Members Found"),
      )
          : ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: ListTile(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MemberDetailsPage(member: member),
                  ),
                );

                if (result == true) {
                  loadMembers();
                }
              },
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Text(
                  member.name.isNotEmpty
                      ? member.name[0].toUpperCase()
                      : "?",
                ),
              ),
              title: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${member.mobile}\n${member.city}",
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMemberPage(),
            ),
          );

          if (result == true) {
            loadMembers();
          }
        },
      ),
    );
  }
}