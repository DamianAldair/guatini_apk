class LicenseModel {
  final int? id;
  final String? name;
  final String? description;

  const LicenseModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory LicenseModel.fromMap(Map<String, dynamic> json) => LicenseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
