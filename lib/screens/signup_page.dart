import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
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
              const Text("Register", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
              ),
              if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (passwordController.text != confirmController.text) {
                    setState(() => error = 'Passwords do not match');
                    return;
                  }
                  try {
                    await auth.register(emailController.text, passwordController.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StatusCheck()));
                    print('Did not go to status check');
                  } catch (e) {
                    setState(() => error = 'Registration failed');
                  }
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
