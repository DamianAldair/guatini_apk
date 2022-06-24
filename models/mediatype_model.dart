enum MediaType {
  audio,
  image,
  video,
}

_setType(String type) {
  if (type == 'Audio') {
    return MediaType.audio;
  } else if (type == 'Imagen') {
    return MediaType.image;
  } else if (type == 'Video') {
    return MediaType.video;
  } else {
    return;
  }
}

class MediaTypeModel {
  final int? id;
  final MediaType? type;

  const MediaTypeModel({
    required this.id,
    required this.type,
  });

  factory MediaTypeModel.fromMap(Map<String, dynamic> json) => MediaTypeModel(
        id: json["id"],
        type: _setType(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
      };
}
