import 'package:flutter/material.dart';
import 'package:practitioner_app/offerings_model.dart';
import 'add_edit_offering_screen.dart'; // Import the edit screen

class DisplayOfferingScreen extends StatelessWidget {
  final Offering offering;

  DisplayOfferingScreen({required this.offering});

  // Function to format duration into hours and minutes
  String formatDuration(String duration) {
    final regex = RegExp(r'(?:(\d+)\s*hr)?(?:\s*(\d+)\s*min)?');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = match.group(1) != null ? int.parse(match.group(1)!) : 0;
      final minutes = match.group(2) != null ? int.parse(match.group(2)!) : 0;

      return '${hours > 0 ? "$hours hr" : ""} ${minutes > 0 ? "$minutes min" : ""}'
          .trim();
    }

    return duration; // Return original if format is unexpected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offering.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                // Scrollable content
                child: Card(
                  elevation: 4, // Add elevation to the card for shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Practitioner: ${offering.practitionerName}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Description: ${offering.description}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Category: ${offering.category}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Duration: ${formatDuration(offering.duration)}", // Display formatted duration
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Type: ${offering.type}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Price: €${offering.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Highlight price
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 150, // Set width for the larger button
        height: 50, // Set height for the larger button
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddEditOfferingScreen(
                    offering: offering), // Pass offering to edit
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8), // Spacing between icon and text
              Text(
                'Edit',
                style:
                    TextStyle(fontSize: 16), // Text size for the button label
              ),
            ],
          ),
          backgroundColor:
              Theme.of(context).primaryColor, // Use theme color for the button
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Center the FAB
    );
  }
}
