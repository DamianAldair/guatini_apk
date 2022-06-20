class EndemismModel {
  final int? id;
  final String? zone;

  const EndemismModel({
    required this.id,
    required this.zone,
  });

  factory EndemismModel.fromMap(Map<String, dynamic> json) => EndemismModel(
        id: json["id"],
        zone: json["zone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "zone": zone,
      };

  @override
  String toString() {
    return zone.toString();
  }
}
