class DietModel {
  final int? id;
  final String? diet;

  const DietModel({
    required this.id,
    required this.diet,
  });

  factory DietModel.fromMap(Map<String, dynamic> json) => DietModel(
        id: json["id"],
        diet: json["diet"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "diet": diet,
      };

  @override
  String toString() {
    return diet!;
  }
}
