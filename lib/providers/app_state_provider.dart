import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _globalLoading = false;

  ThemeMode get themeMode => _themeMode;
  bool get globalLoading => _globalLoading;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setGlobalLoading(bool v) {
    if (_globalLoading == v) return;
    _globalLoading = v;
    notifyListeners();
  }
}
