import 'package:flutter/material.dart';
import 'package:practitioner_app/model/offerings_model.dart';

class OfferingsProvider with ChangeNotifier {
  List<Offering> _offerings = [];

  List<Offering> get offerings => _offerings;

  void addOffering(Offering offering) {
    _offerings.add(offering);
    notifyListeners();
  }

  void updateOffering(String id, Offering newOffering) {
    final index = _offerings.indexWhere((offer) => offer.id == id);
    if (index >= 0) {
      _offerings[index] = newOffering;
      notifyListeners();
    }
  }

  void deleteOffering(String id) {
    _offerings.removeWhere((offer) => offer.id == id);
    notifyListeners();
  }
}
