import 'package:flutter/material.dart';
import 'package:practitioner_app/view/widgets/delete_confirmation.dart';
import 'package:practitioner_app/view/widgets/offering_list_card.dart';
import 'package:practitioner_app/view_model/offerings_provider.dart';
import 'package:provider/provider.dart';
import 'add_edit_offering_page.dart';

class OfferingsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offeringsProvider = Provider.of<OfferingsProvider>(context);

    offeringsProvider.fetchOfferings();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Offering',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OfferingsListWidget(offeringsProvider: offeringsProvider),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditOfferingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class OfferingsListWidget extends StatelessWidget {
  final OfferingsProvider offeringsProvider;

  const OfferingsListWidget({required this.offeringsProvider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: offeringsProvider.fetchOfferings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (offeringsProvider.offerings.isEmpty) {
          return const Center(
            child: Text(
              'No offerings available.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: offeringsProvider.offerings.length,
          itemBuilder: (context, index) {
            final offering = offeringsProvider.offerings[index];
            return OfferingCardListView(
              offering: offering,
              onDelete: () {
                _showDeleteConfirmationDialog(
                    context, offering.id, offeringsProvider);
              },
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String offeringId,
      OfferingsProvider offeringsProvider) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        onDelete: () {
          offeringsProvider.deleteOffering(offeringId);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
