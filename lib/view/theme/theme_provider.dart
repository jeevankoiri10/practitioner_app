import 'package:flutter/material.dart';

enum AppTheme { my_new_earth, blue, green, red, purple }

class ThemeProvider with ChangeNotifier {
  // Map of themes based on the AppTheme enum
  static final Map<AppTheme, ThemeData> themes = {
    AppTheme.my_new_earth: _buildTheme(
      primaryColor: const Color.fromARGB(255, 223, 113, 152),
      appBarColor: const Color.fromARGB(255, 223, 113, 152),
      floatingActionButtonColor: const Color.fromARGB(255, 223, 113, 152),
    ),
    AppTheme.blue: _buildTheme(
      primaryColor: Colors.blue,
      appBarColor: Colors.blue,
      floatingActionButtonColor: Colors.blue,
    ),
    AppTheme.green: _buildTheme(
      primaryColor: Colors.green,
      appBarColor: Colors.green,
      floatingActionButtonColor: Colors.green,
    ),
    AppTheme.red: _buildTheme(
      primaryColor: Colors.red,
      appBarColor: Colors.red,
      floatingActionButtonColor: Colors.red,
    ),
    AppTheme.purple: _buildTheme(
      primaryColor: Colors.purple,
      appBarColor: Colors.purple,
      floatingActionButtonColor: Colors.purple,
    ),
  };

  // Initial theme
  AppTheme _currentTheme = AppTheme.my_new_earth;

  ThemeData get themeData => themes[_currentTheme]!;

  AppTheme get currentTheme => _currentTheme;

  void updateTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  // Helper method to build the theme with reusable components
  static ThemeData _buildTheme({
    required Color primaryColor,
    required Color appBarColor,
    required Color floatingActionButtonColor,
  }) {
    return ThemeData(
      primaryColor: primaryColor,
      appBarTheme: _buildAppBarTheme(appBarColor),
      floatingActionButtonTheme:
          _buildFloatingActionButtonTheme(floatingActionButtonColor),
      scaffoldBackgroundColor: Colors.white,
      textTheme: _buildTextTheme(),
      useMaterial3: true,
    );
  }

  // Modularized AppBar theme component
  static AppBarTheme _buildAppBarTheme(Color color) {
    return AppBarTheme(
      color: color,
      titleTextStyle: const TextStyle(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  // Modularized FloatingActionButton theme component
  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme(
      Color color) {
    return FloatingActionButtonThemeData(
      backgroundColor: color,
      foregroundColor: Colors.white,
    );
  }

  // Updated TextTheme component using Material 3 styles
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
    );
  }
}
