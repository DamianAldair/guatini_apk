class AbundanceModel {
  final int? id;
  final String? abundance;

  const AbundanceModel({
    required this.id,
    required this.abundance,
  });

  factory AbundanceModel.fromMap(Map<String, dynamic> json) => AbundanceModel(
        id: json["id"],
        abundance: json["abundance"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "abundance": abundance,
      };
}
