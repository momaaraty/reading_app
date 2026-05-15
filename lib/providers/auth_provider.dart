import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool loading = false;
  String? error;

  Future<bool> login(String email, String password) async {
    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    user = User(id: "1", name: "User", email: email);

    loading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signup(String name, String email, String password) async {
    loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    user = User(id: "2", name: name, email: email);

    loading = false;
    notifyListeners();
    return true;
  }

  void signOut() {
    user = null;
    notifyListeners();
  }
}
