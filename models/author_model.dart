class AuthorModel {
  final int? id;
  final String? name;
  final String? description;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory AuthorModel.fromMap(Map<String, dynamic> json) => AuthorModel(
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
