import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  bool loading = false;
  String? error;

  // =========================
  // INIT STATE (Splash control)
  // =========================
  bool _initialized = false;
  bool get initialized => _initialized;

  bool get isLoggedIn => user != null;

  // =========================
  // BOOT STATUS (for Splash stages)
  // =========================
  String _status = "Starting...";
  String get status => _status;

  void _setStatus(String value) {
    _status = value;
    notifyListeners();
  }

  // =========================
  // INIT AUTH (SMART SPLASH CORE)
  // =========================
  Future<void> initAuth() async {
    _setStatus("Checking session...");

    await Future.delayed(const Duration(milliseconds: 600));

    // 🔥 مستقبلًا: SharedPreferences / Firebase / Token check
    _setStatus("Loading user data...");

    await Future.delayed(const Duration(milliseconds: 600));

    // simulate stored session (حالياً لا يوجد مستخدم محفوظ)
    user = null;

    _setStatus("Finalizing authentication...");

    await Future.delayed(const Duration(milliseconds: 400));

    _initialized = true;
    notifyListeners();
  }

  // =========================
  // LOGIN
  // =========================
  Future<bool> login(String email, String password) async {
    loading = true;
    _setStatus("Signing in...");
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    user = User(id: "1", name: "User", email: email);

    loading = false;
    _setStatus("Login successful");
    notifyListeners();

    return true;
  }

  // =========================
  // SIGNUP
  // =========================
  Future<bool> signup(String name, String email, String password) async {
    loading = true;
    _setStatus("Creating account...");
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    user = User(id: "2", name: name, email: email);

    loading = false;
    _setStatus("Account created");
    notifyListeners();

    return true;
  }

  // =========================
  // LOGOUT
  // =========================
  void signOut() {
    user = null;
    _setStatus("Signed out");
    notifyListeners();
  }
}
