// Extracted widget for rendering the list of offerings
import 'package:flutter/material.dart';
import 'package:practitioner_app/model/offerings_model.dart';
import 'package:practitioner_app/view/ui/offerings_details_page.dart';
import 'package:practitioner_app/view/ui/offerings_list_page.dart';
import 'package:practitioner_app/view/widgets/delete_confirmation.dart';
import 'package:practitioner_app/view_model/offerings_provider.dart';

// Extracted widget for each offering card
class OfferingCardListView extends StatelessWidget {
  final Offering offering;
  final VoidCallback onDelete;

  const OfferingCardListView({
    required this.offering,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: _buildSubtitle(),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OfferingDetailsPage(offering: offering),
            ),
          );
        },
      ),
    );
  }

  // Method to build subtitle
  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offering.practitionerName,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          'Category: ${offering.category.toString().split('.').last.capitalize()}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          'Duration: ${_formatDuration(offering.duration)}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          'Type: ${offering.type.toString().split('.').last.capitalize()}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          'Price: €${offering.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Helper method to format Duration in hours and minutes
  String _formatDuration(Duration duration) {
    final hours = duration.inMinutes ~/ 60;
    final minutes = duration.inMinutes % 60;
    return '${hours > 0 ? "$hours hr " : ""}${minutes > 0 ? "$minutes min" : ""}'
        .trim();
  }
}
