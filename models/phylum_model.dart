import 'package:guatini/models/kindom_model.dart';

class PhylumModel {
  final int? id;
  final String? name;
  final String? description;
  final KindomModel? taxkindom;

  const PhylumModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxkindom,
  });

  factory PhylumModel.fromMap(Map<String, dynamic> json) => PhylumModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_kindom_": taxkindom?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
