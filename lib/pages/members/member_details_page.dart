import 'package:flutter/material.dart';
import '../../models/member.dart';
import 'edit_member_page.dart';
import '../../services/member_service.dart';

class MemberDetailsPage extends StatelessWidget {
  final Member member;

  const MemberDetailsPage({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple.shade100,
                child: Text(
                  member.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 35),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text("Name : ${member.name}",
                style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 10),

            Text("Mobile : ${member.mobile}"),
            Text("Email : ${member.email}"),
            Text("City : ${member.city}"),
            Text("Gender : ${member.gender}"),
            Text("Membership : ${member.membership}"),
            const Text("Total Events Performed : 0"),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("EDIT MEMBER"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditMemberPage(member: member),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("DELETE MEMBER"),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete Member"),
                      content: const Text(
                        "Are you sure you want to delete this member?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final service = MemberService();

                    await service.deleteMember(member.id!);

                    if (context.mounted) {
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}