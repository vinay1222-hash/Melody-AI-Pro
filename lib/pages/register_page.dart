import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final songController = TextEditingController();
  final singerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Full Name",
            ),
          ),
          SizedBox(height: 15),

          TextField(
            controller: mobileController,
            decoration: InputDecoration(
              labelText: "Mobile Number",
            ),
          ),
          SizedBox(height: 15),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: songController,
            decoration: InputDecoration(
              labelText: "Song Name",
            ),
          ),
          SizedBox(height: 15),

          TextField(
            controller: singerController,
            decoration: InputDecoration(
              labelText: "Singer Name",
            ),
          ),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              print(nameController.text);
              print(mobileController.text);
              print(emailController.text);
              print(songController.text);
              print(singerController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration Successful!"),
                ),
              );
            },
            child: Text("Submit"),
          ),
        ],
      ),
    ),
    );
  }
}