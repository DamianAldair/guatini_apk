import 'package:guatini/models/class_model.dart';

class OrderModel {
  final int? id;
  final String? name;
  final String? description;
  final ClassModel? taxclass;

  const OrderModel({
    required this.id,
    required this.name,
    required this.description,
    this.taxclass,
  });

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "fk_t_class_": taxclass?.id,
      };

  @override
  String toString() {
    return name.toString();
  }
}
