import 'package:flutter/material.dart';
import 'storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode getMode() => _themeMode;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeMode = ThemeMode.light;
      } else if (themeMode == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void setSystemMode() async {
    _themeMode = ThemeMode.system;
    StorageManager.saveData('themeMode', 'system');
    notifyListeners();
  }
}
