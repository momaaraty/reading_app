import 'package:flutter/material.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({super.key});

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final ctrl = TextEditingController();

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  void _send() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sent")),
    );
    ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write here...",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _send,
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}