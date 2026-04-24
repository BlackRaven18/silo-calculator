import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/silo.dart';

class StorageService {
  static const String _keyTheme = 'theme_mode';
  static const String _keySilos = 'saved_silos';
  static const String _keyLanguage = 'language_code';

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, mode.name);
  }

  static Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeName = prefs.getString(_keyTheme);
    if (themeName == null) return ThemeMode.system;
    return ThemeMode.values.firstWhere(
      (m) => m.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, langCode);
  }

  static Future<String> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'pl';
  }

  static Future<void> saveSilos(List<Silo> silos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      silos.map((silo) => silo.toMap()).toList(),
    );
    await prefs.setString(_keySilos, encodedData);
  }

  static Future<List<Silo>> loadSilos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_keySilos);

    if (encodedData == null || encodedData.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((item) => Silo.fromMap(item)).toList();
    } catch (e) {
      return [];
    }
  }
}
