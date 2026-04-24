import 'package:flutter/material.dart';
import '../core/services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _languageCode = 'pl';

  SettingsViewModel() {
    _loadSettings();
  }

  ThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;

  Future<void> _loadSettings() async {
    _themeMode = await StorageService.loadThemeMode();
    _languageCode = await StorageService.loadLanguage();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    StorageService.saveThemeMode(_themeMode);
    notifyListeners();
  }

  void setLanguage(String code) {
    if (_languageCode != code) {
      _languageCode = code;
      StorageService.saveLanguage(code);
      notifyListeners();
    }
  }
}
