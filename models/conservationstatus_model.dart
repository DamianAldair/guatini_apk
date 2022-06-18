class ConservationStatusModel {
  final int? id;
  final int? status;

  const ConservationStatusModel({
    required this.id,
    required this.status,
  });

  factory ConservationStatusModel.fromMap(Map<String, dynamic> json) =>
      ConservationStatusModel(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
      };
}
