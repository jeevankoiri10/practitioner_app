import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'offerings_provider.dart';
import 'offerings_list_screen.dart';
import 'theme_provider.dart';

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
            home: OfferingsListScreen(),
          );
        },
      ),
    );
  }
}
