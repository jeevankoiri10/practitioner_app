enum ServiceCategory { mental, spiritual, emotional }

enum ServiceType { inPerson, online }

class Offering {
  String id;
  String practitionerName;
  String title;
  String description;
  ServiceCategory category;
  Duration duration;
  ServiceType type;
  double price;

  Offering({
    required this.id,
    required this.practitionerName,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.type,
    required this.price,
  });

  // Convert a JSON object to an Offering instance
  factory Offering.fromJson(Map<String, dynamic> json) {
    return Offering(
      id: json['id'] as String,
      practitionerName: json['practitionerName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: ServiceCategory.values.firstWhere(
          (e) => e.toString() == 'ServiceCategory.${json['category']}'),
      duration: Duration(
          minutes: json['duration'] as int), // Convert duration from minutes
      type: ServiceType.values
          .firstWhere((e) => e.toString() == 'ServiceType.${json['type']}'),
      price: json['price'] as double,
    );
  }

  // Convert an Offering instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'practitionerName': practitionerName,
      'title': title,
      'description': description,
      'category': category.toString().split('.').last,
      'duration': duration.inMinutes, // Store duration as minutes in JSON
      'type': type.toString().split('.').last,
      'price': price,
    };
  }
}
