import 'package:flutter/material.dart';
import 'package:practitioner_app/view/ui/display_offerings.dart';
import 'package:practitioner_app/view_model/offerings_provider.dart';
import 'package:practitioner_app/view/widgets/myne_app_bar.dart';
import 'package:provider/provider.dart';
import 'edit_offering_screen.dart';
import 'settings_screen.dart';

class OfferingsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offeringsProvider = Provider.of<OfferingsProvider>(context);

    return Scaffold(
      appBar: MYNEappBar(title: 'Offerings'), // TODO add settings in the appbar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: offeringsProvider.offerings.length,
          itemBuilder: (context, index) {
            final offering = offeringsProvider.offerings[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  offering.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offering.practitionerName,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Price: €${offering.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(
                        context, offering.id, offeringsProvider);
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayOfferingScreen(offering: offering),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // TODO add the white foreground on the floating action button
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditOfferingScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String offeringId,
      OfferingsProvider offeringsProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Offering'),
        content: Text('Are you sure you want to delete this offering?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              offeringsProvider.deleteOffering(offeringId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
