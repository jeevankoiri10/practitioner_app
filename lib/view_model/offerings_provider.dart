import 'package:flutter/material.dart';
import 'package:practitioner_app/model/offerings_model.dart';

class OfferingsProvider with ChangeNotifier {
  List<Offering> _offerings = [];

  List<Offering> get offerings =>
      List.unmodifiable(_offerings); // Prevent external modifications

  // Add a new offering
  void addOffering(Offering offering) {
    _offerings.add(offering);
    notifyListeners();
  }

  // Update an existing offering by ID
  void updateOffering(String id, Offering updatedOffering) {
    final index = _offerings.indexWhere((offer) => offer.id == id);
    if (index != -1) {
      _offerings[index] = updatedOffering;
      notifyListeners();
    } else {
      debugPrint("Offering with id $id not found for update.");
    }
  }

  // Delete an offering by ID
  void deleteOffering(String id) {
    final offeringExists = _offerings.any((offer) => offer.id == id);
    if (offeringExists) {
      _offerings.removeWhere((offer) => offer.id == id);
      notifyListeners();
    } else {
      debugPrint("Offering with id $id not found for deletion.");
    }
  }
}
