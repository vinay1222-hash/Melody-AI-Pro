import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool obscurePassword = true;
bool rememberMe = false;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xffF5F5F5),
body: SafeArea(
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.all(24),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [

const SizedBox(height: 20),

CircleAvatar(
radius: 60,
backgroundColor: Colors.white,
child: ClipOval(
child: Image.asset(
'assets/images/logo.png',
fit: BoxFit.cover,
width: 110,
height: 110,
),
),
),

const SizedBox(height: 25),

const Text(
"Melody AI Pro",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Colors.deepPurple,
),
),

const SizedBox(height: 8),

const Text(
"Music • Masti • Magic",
style: TextStyle(
fontSize: 16,
color: Colors.black54,
),
),

const SizedBox(height: 35),

TextField(
controller: emailController,
decoration: InputDecoration(
labelText: "Email",
prefixIcon: const Icon(Icons.email),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
),
),
),

const SizedBox(height: 18),

TextField(
controller: passwordController,
obscureText: obscurePassword,
decoration: InputDecoration(
labelText: "Password",
prefixIcon: const Icon(Icons.lock),
suffixIcon: IconButton(
icon: Icon(
obscurePassword
? Icons.visibility
: Icons.visibility_off,
),
onPressed: () {
setState(() {
obscurePassword = !obscurePassword;
});
},
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(15),
),
),
),

const SizedBox(height: 15),

Row(
children: [

Checkbox(
value: rememberMe,
onChanged: (value) {
setState(() {
rememberMe = value!;
});
},
),

const Text("Remember Me"),

const Spacer(),

TextButton(
onPressed: () {},
child: const Text("Forgot Password?"),
),

],
),

const SizedBox(height: 15),

SizedBox(
width: double.infinity,
height: 55,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.deepPurple,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
),
),
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => const HomePage(),
),
);
},
child: const Text(
"LOGIN",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),

const SizedBox(height: 20),OutlinedButton(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        ),
      );
    },
    child: const Text(
      "REGISTER",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 15),

  TextButton(
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    },
    child: const Text(
      "Continue as Guest",
      style: TextStyle(
        fontSize: 16,
        color: Colors.deepPurple,
      ),
    ),
  ),

  const SizedBox(height: 30),

  const Text(
    "Version 1.0.0",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 13,
    ),
  ),

  const SizedBox(height: 10),

  const Text(
    "© 2026 Melody AI Pro",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
  ),

],
),
),
),
),
);
}

@override
void dispose() {
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
}