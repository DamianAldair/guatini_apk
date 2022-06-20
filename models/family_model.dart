import 'package:guatini/models/order_model.dart';

class FamilyModel {
  final int? id;
  final String? name;
  final String? description;
  final OrderModel? taxorder;

  const FamilyModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxorder,
  });

  factory FamilyModel.fromMap(Map<String, dynamic> json) => FamilyModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_order_": taxorder?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
