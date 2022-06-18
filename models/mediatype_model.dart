class MediaTypeModel {
  final int? id;
  final String? type;

  const MediaTypeModel({
    required this.id,
    required this.type,
  });

  factory MediaTypeModel.fromMap(Map<String, dynamic> json) => MediaTypeModel(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
      };
}
