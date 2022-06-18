import 'package:guatini/models/specie_model.dart';

class CommonNameModel {
  final int? id;
  final String? name;
  final SpecieModel? specie;

  const CommonNameModel({
    required this.id,
    required this.name,
    this.specie,
  });

  factory CommonNameModel.fromMap(Map<String, dynamic> json) => CommonNameModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "fk_specie_": specie?.id,
      };
}
