import 'package:flutter/material.dart';
import 'login_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MelodyStudioApp());
}

class MelodyStudioApp extends StatelessWidget {
  const MelodyStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melody AI Pro',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}