class Offering {
  String id; // Unique identifier
  String practitionerName;
  String title;
  String description;
  String category;
  String duration;
  String type; // In-Person or Online
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
}
