import 'package:flutter/material.dart';
import 'package:practitioner_app/view/ui/edit_offering_page.dart';
import 'package:practitioner_app/view/ui/settings_page.dart';
import 'package:provider/provider.dart';
import 'view_model/offerings_provider.dart';
import 'view/ui/offerings_list_page.dart';
import 'view/theme/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OfferingsProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Holistic Practitioner Services: MyNewEarth',
            theme: themeProvider.themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => OfferingsListPage(),
              '/add': (context) => AddEditOfferingPage(),
              '/settings': (context) => SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
