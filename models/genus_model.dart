import 'package:guatini/models/family_model.dart';

class GenusModel {
  final int? id;
  final String? name;
  final String? description;
  final FamilyModel? taxfamily;

  const GenusModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxfamily,
  });

  factory GenusModel.fromMap(Map<String, dynamic> json) => GenusModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_family_": taxfamily?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
