import 'package:flutter/material.dart';
import 'package:practitioner_app/view/widgets/myne_app_bar.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: MYNEappBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('Select a Theme Color:'),
            const SizedBox(height: 20),
            _buildThemeOptions(context, themeProvider),
          ],
        ),
      ),
    );
  }

  // Builds the title for the settings page
  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Builds the theme options list dynamically
  Widget _buildThemeOptions(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: AppTheme.values.map((theme) {
        return _ThemeOptionTile(
          theme: theme,
          isSelected: theme == themeProvider.currentTheme,
          onChanged: (AppTheme? selectedTheme) {
            if (selectedTheme != null) {
              themeProvider.updateTheme(selectedTheme);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }
}

// Modular component for each theme option tile
class _ThemeOptionTile extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final ValueChanged<AppTheme?> onChanged;

  const _ThemeOptionTile({
    required this.theme,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
      leading: Radio<AppTheme>(
        value: theme,
        groupValue: isSelected ? theme : null,
        onChanged: onChanged,
      ),
      title: Text(
        theme.toString().split('.').last,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      tileColor:
          isSelected ? Theme.of(context).highlightColor : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
