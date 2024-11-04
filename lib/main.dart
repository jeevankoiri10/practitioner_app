import 'package:flutter/material.dart';
import 'package:practitioner_app/offering_list_screen.dart';
import 'package:provider/provider.dart';
import 'offerings_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfferingsProvider(),
      child: MaterialApp(
        title: 'Holistic Practitioner Services',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OfferingsListScreen(),
      ),
    );
  }
}
