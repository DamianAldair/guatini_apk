import 'dart:ffi';

import 'package:guatini/models/license_model.dart';
import 'package:guatini/models/mediatype_model.dart';
import 'package:guatini/models/specie_model.dart';

class MediaModel {
  final int? id;
  final String? path;
  final String? dateCapture;
  final Float? latitude;
  final Float? longitude;
  final SpecieModel? specie;
  final LicenseModel? license;
  MediaTypeModel? type;

  MediaModel({
    required this.id,
    required this.path,
    required this.dateCapture,
    required this.latitude,
    required this.longitude,
    this.specie,
    this.license,
  });

  factory MediaModel.fromMap(Map<String, dynamic> json) => MediaModel(
        id: json["id"],
        path: json["path"],
        dateCapture: json["dateCapture"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
        "dateCapture": dateCapture,
        "latitude": latitude,
        "longitude": longitude,
        "fk_specie_": specie?.id,
        "fk_license_": license?.id,
        "fk_type_": type?.id,
      };

  set mediaType(MediaTypeModel type) => this.type = type;
  MediaTypeModel get mediaType => type!;
}

class MainImageModel extends MediaModel {
  MainImageModel({
    required int? id,
    required String? path,
    required String? dateCapture,
    required Float? latitude,
    required Float? longitude,
    SpecieModel? specie,
    LicenseModel? license,
  }) : super(
          id: id,
          path: path,
          dateCapture: dateCapture,
          latitude: latitude,
          longitude: longitude,
          specie: specie,
          license: license,
        );

  factory MainImageModel.fromMap(Map<String, dynamic> json) => MainImageModel(
        id: json["id"],
        path: json["path"],
        dateCapture: json["dateCapture"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}
