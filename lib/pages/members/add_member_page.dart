import 'package:flutter/material.dart';
import '../../models/member.dart';
import '../../services/member_service.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {

  final _formKey = GlobalKey<FormState>();
  final MemberService _memberService = MemberService();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();

  String gender = "Male";
  String membership = "Member";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(
                  Icons.person,
                  size: 60,
                ),
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Gender",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: membership,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Membership",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Member",
                    child: Text("Member"),
                  ),
                  DropdownMenuItem(
                    value: "Admin",
                    child: Text("Admin"),
                  ),
                  DropdownMenuItem(
                    value: "Guest",
                    child: Text("Guest"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    membership = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "SAVE MEMBER",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: ()async{

                    if (_formKey.currentState!.validate()) {

                      final member = Member(
                        name: nameController.text,
                        mobile: mobileController.text,
                        email: emailController.text,
                        city: cityController.text,
                        gender: gender,
                        membership: membership,
                      );

                      await _memberService.addMember(member);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Member Saved Successfully"),
                        ),
                      );

                      Navigator.pop(context, true);
                    }

                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}