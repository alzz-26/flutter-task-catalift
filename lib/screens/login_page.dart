import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/dashboard.dart';
import '../services/auth_service.dart';
import 'signup_page.dart';
import 'onboarding/education_details.dart';

class StatusCheck extends StatelessWidget {
  const StatusCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    if (auth.user == null) {
      print('checking logged out user');
      return const LoginPage(); // Not logged in
    } else if (auth.newUser == true) {
      print('checking new user');
      return const EducationDetailsScreen(); // First-time login
    } else {
      print('checking logged in user');
      return const DashboardPage(); // Regular user
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text("Login", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await auth.signInWithEmail(emailController.text, passwordController.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StatusCheck()));
                  } catch (e) {
                    setState(() => error = 'Login failed');
                  }
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpPage())),
                child: const Text("Register"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await auth.signInWithGoogle();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StatusCheck()));
                },
                child: const Text("Sign in with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
