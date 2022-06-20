import 'package:guatini/models/phylum_model.dart';

class ClassModel {
  final int? id;
  final String? name;
  final String? description;
  final PhylumModel? taxphylum;

  const ClassModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxphylum,
  });

  factory ClassModel.fromMap(Map<String, dynamic> json) => ClassModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_phylum_": taxphylum?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
