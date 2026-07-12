import 'package:flutter/material.dart';
import '../../services/member_service.dart';

import '../../models/member.dart';

class EditMemberPage extends StatefulWidget {
  final Member member;

  const EditMemberPage({
    super.key,
    required this.member,
  });

  @override
  State<EditMemberPage> createState() => _EditMemberPageState();
}

class _EditMemberPageState extends State<EditMemberPage> {
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.member.name);
    mobileController =
        TextEditingController(text: widget.member.mobile);
    emailController =
        TextEditingController(text: widget.member.email);
    cityController =
        TextEditingController(text: widget.member.city);
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Member"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: "Mobile",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "City",
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                widget.member.name = nameController.text;
                widget.member.mobile = mobileController.text;
                widget.member.email = emailController.text;
                widget.member.city = cityController.text;

                final service = MemberService();

                await service.updateMember(widget.member);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Member Updated Successfully"),
                    ),
                  );

                  Navigator.pop(context, true);
                }
              },
              child: const Text("UPDATE MEMBER"),
            ),
          ],
        ),
      ),
    );
  }
}