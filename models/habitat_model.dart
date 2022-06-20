class HabitatModel {
  final int? id;
  final String? habitat;

  const HabitatModel({
    required this.habitat,
    required this.id,
  });

  factory HabitatModel.fromMap(Map<String, dynamic> json) => HabitatModel(
        id: json["id"],
        habitat: json["habitat"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "habitat": habitat,
      };

  @override
  String toString() {
    return habitat!;
  }
}
