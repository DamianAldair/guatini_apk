import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';

class SpecieFromSimpleSearch {
  final int? id;
  final String? name;
  final String? scientificName;
  final String? imagePath;

  const SpecieFromSimpleSearch({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.imagePath,
  });

  factory SpecieFromSimpleSearch.fromMap(Map<String, dynamic> json) =>
      SpecieFromSimpleSearch(
        id: json["id"],
        name: json["name"],
        scientificName: json["scientific_name"],
        imagePath: json["path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "scientific_name": scientificName,
        "path": imagePath,
      };

  get image {
    final _prefs = UserPreferences();
    final _dbPath = _prefs.dbPath;
    return FutureBuilder(
      future: File('$_dbPath$imagePath').exists(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return Image.file(
              File('$_dbPath$imagePath'),
              fit: BoxFit.cover,
            );
          } else {
            return Image.asset(
              'assets/images/image_not_available.png',
              fit: BoxFit.cover,
            );
          }
        } else {
          return Image.asset(
            'assets/images/loading.gif',
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
