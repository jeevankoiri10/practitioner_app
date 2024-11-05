import 'package:flutter/material.dart';

// Enum for available themes
enum AppTheme { blue, green, red, purple }

class ThemeProvider with ChangeNotifier {
  // Map of themes based on the AppTheme enum
  static final Map<AppTheme, ThemeData> themes = {
    AppTheme.blue: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    AppTheme.green: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    ),
    AppTheme.red: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      useMaterial3: true,
    ),
    AppTheme.purple: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      useMaterial3: true,
    ),
  };

  // Initial theme
  AppTheme _currentTheme = AppTheme.blue;

  ThemeData get themeData => themes[_currentTheme]!;

  AppTheme get currentTheme => _currentTheme;

  void updateTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
