class DomainModel {
  final int? id;
  final String? name;
  final String? description;

  const DomainModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DomainModel.fromMap(Map<String, dynamic> json) => DomainModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
      };

  @override
  String toString() {
    return name.toString();
  }
}
