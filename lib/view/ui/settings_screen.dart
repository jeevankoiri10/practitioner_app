import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a theme color:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Column(
              children: AppTheme.values.map((theme) {
                return ListTile(
                  title: Text(theme.toString().split('.').last),
                  leading: Radio<AppTheme>(
                    value: theme,
                    groupValue: themeProvider.currentTheme,
                    onChanged: (AppTheme? selectedTheme) {
                      if (selectedTheme != null) {
                        themeProvider.updateTheme(selectedTheme);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
