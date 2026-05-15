import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: name),
          TextField(controller: email),
          TextField(controller: password),

          ElevatedButton(
            onPressed: () async {
              await auth.signup(name.text, email.text, password.text);
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text("إنشاء حساب"),
          )
        ],
      ),
    );
  }
}