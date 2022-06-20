import 'package:guatini/models/domain_model.dart';

class KindomModel {
  final int? id;
  final String? name;
  final String? description;
  final DomainModel? taxdomain;

  const KindomModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxdomain,
  });

  factory KindomModel.fromMap(Map<String, dynamic> json) => KindomModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_domain_": taxdomain?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
