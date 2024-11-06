// Widget for the offering card
import 'package:flutter/material.dart';
import 'package:practitioner_app/model/offerings_model.dart';

class OfferingDetailsCard extends StatelessWidget {
  final String practitionerName;
  final String description;
  final ServiceCategory category;
  final Duration duration;
  final ServiceType type;
  final double price;
  final String Function(Duration) formatDuration;

  OfferingDetailsCard({
    required this.practitionerName,
    required this.description,
    required this.category,
    required this.duration,
    required this.type,
    required this.price,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText('Practitioner: $practitionerName',
                fontWeight: FontWeight.bold),
            _buildText('Description: $description'),
            _buildText('Category: ${category.toString().split('.').last}'),
            _buildText('Duration: ${formatDuration(duration)}'),
            _buildText('Type: ${type.toString().split('.').last}'),
            _buildPrice('Price: €${price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  // Helper method to create styled text
  Widget _buildText(String text, {FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: fontWeight),
      ),
    );
  }

  // Custom price text widget with enhanced style
  Widget _buildPrice(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
