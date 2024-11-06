import 'package:flutter/material.dart';
import 'package:practitioner_app/model/database_helper.dart';
import 'package:practitioner_app/model/offerings_model.dart';
import 'package:practitioner_app/view/widgets/custom_edit_button.dart';
import 'package:practitioner_app/view/widgets/myne_app_bar.dart';
import 'package:practitioner_app/view/widgets/offerings_details_card.dart';
import 'add_edit_offering_page.dart';

class OfferingDetailsPage extends StatefulWidget {
  final Offering offering;

  OfferingDetailsPage({required this.offering});

  @override
  State<OfferingDetailsPage> createState() => _OfferingDetailsPageState();
}

class _OfferingDetailsPageState extends State<OfferingDetailsPage> {
  late Offering _offering;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _offering = widget.offering;
  }

  // Function to format duration from minutes to hours and minutes
  String formatDuration(Duration duration) {
    if (duration == Duration(minutes: 0, seconds: 0)) {
      return "0 min";
    }
    final totalMinutes = duration.inMinutes;
    final hours = totalMinutes ~/ 60; // Integer division for hours
    final minutes = totalMinutes % 60; // Remainder for minutes

    return '${hours > 0 ? "$hours hr" : ""} ${minutes > 0 ? "$minutes min" : ""}'
        .trim();
  }

  // Update the offering in the database
  Future<void> _updateOfferingInDatabase() async {
    await dbHelper.updateOffering(_offering);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MYNEappBar(title: _offering.title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OfferingDetailsCard(
                practitionerName: _offering.practitionerName,
                description: _offering.description,
                category: _offering.category,
                duration: _offering.duration,
                type: _offering.type,
                price: _offering.price,
                formatDuration: formatDuration,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: EditButton(
        onPressed: () async {
          final updatedOffering = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditOfferingPage(offering: _offering),
            ),
          );

          if (updatedOffering != null) {
            setState(() {
              _offering = updatedOffering;
              _updateOfferingInDatabase(); // Update the offering in DB
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
