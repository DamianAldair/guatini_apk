class AdModel {
  final int? id;
  final String? path;
  final String? url;

  const AdModel({
    required this.id,
    required this.path,
    required this.url,
  });

  factory AdModel.fromMap(Map<String, dynamic> json) => AdModel(
        id: json["id"],
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
        "url": url,
      };
}
