import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'offerings_provider.dart';

import 'add_edit_offering_screen.dart';

class OfferingsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offeringsProvider = Provider.of<OfferingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Offerings'),
        actions: [],
      ),
      body: ListView.builder(
        itemCount: offeringsProvider.offerings.length,
        itemBuilder: (context, index) {
          final offering = offeringsProvider.offerings[index];
          return ListTile(
            title: Text(offering.title),
            subtitle: Text(offering.practitionerName),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                offeringsProvider.deleteOffering(offering.id);
              },
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AddEditOfferingScreen(offering: offering),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditOfferingScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
