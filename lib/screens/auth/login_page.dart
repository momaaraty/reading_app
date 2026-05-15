import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: email),
            TextField(controller: password),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                bool ok = await auth.login(email.text, password.text);
                if (ok && mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text("تسجيل الدخول"),
            )
          ],
        ),
      ),
    );
  }
}