import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  User? _user; // simple in-memory user

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? e) {
    _error = e;
    notifyListeners();
  }

  String? _validateName(String name) {
    if (name.trim().isEmpty) return 'الاسم مطلوب';
    return null;
  }

  String? _validateEmail(String email) {
    if (email.trim().isEmpty) return 'الايميل مطلوب';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'كلمة السر مطلوبة';
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return 'كلمة السر غير متطابقة';
    return null;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    _setError(null);

    final emailError = _validateEmail(email);
    if (emailError != null) {
      _setError(emailError);
      return false;
    }

    _setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    _setLoading(false);
    return true;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String? profileImagePath,
  }) async {
    _setError(null);

    // Validation
    final nameError = _validateName(name);
    if (nameError != null) {
      _setError(nameError);
      return false;
    }

    final emailError = _validateEmail(email);
    if (emailError != null) {
      _setError(emailError);
      return false;
    }

    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      _setError(passwordError);
      return false;
    }

    final confirmError = _validateConfirmPassword(password, confirmPassword);
    if (confirmError != null) {
      _setError(confirmError);
      return false;
    }

    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));

    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      email: email.trim(),
      profileImagePath: profileImagePath,
    );

    _setLoading(false);
    return true;
  }

  Future<bool> signIn({required String email, required String password}) async {
    _setError(null);

    // Validation
    final emailError = _validateEmail(email);
    if (emailError != null) {
      _setError(emailError);
      return false;
    }

    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      _setError(passwordError);
      return false;
    }

    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));

    // For demo: accept any credentials and create a session-like user
    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'User',
      email: email.trim(),
    );

    _setLoading(false);
    return true;
  }

  void signOut() {
    _user = null;
    notifyListeners();
  }
}
