import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;
    ImageProvider? avatarImage;
    if (user?.profileImagePath != null) {
      final path = user!.profileImagePath!;
      if (path.startsWith('http')) {
        avatarImage = NetworkImage(path);
      } else {
        avatarImage = FileImage(File(path));
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user != null) ...[
              CircleAvatar(
                radius: 36,
                backgroundImage: avatarImage,
                child: avatarImage == null
                    ? const Icon(Icons.person, size: 36)
                    : null,
              ),
              const SizedBox(height: 12),
              Text(user.name),
              const SizedBox(height: 8),
              Text(user.email),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
    );
  }
}
