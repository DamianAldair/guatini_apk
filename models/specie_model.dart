import 'package:guatini/models/abundance_model.dart';
import 'package:guatini/models/activity_model.dart';
import 'package:guatini/models/class_model.dart';
import 'package:guatini/models/commonmane_model.dart';
import 'package:guatini/models/conservationstatus_model.dart';
import 'package:guatini/models/diet_model.dart';
import 'package:guatini/models/domain_model.dart';
import 'package:guatini/models/endemism_model.dart';
import 'package:guatini/models/family_model.dart';
import 'package:guatini/models/genus_model.dart';
import 'package:guatini/models/habitat_model.dart';
import 'package:guatini/models/kindom_model.dart';
import 'package:guatini/models/media_model.dart';
import 'package:guatini/models/order_model.dart';
import 'package:guatini/models/phylum_model.dart';

class SpecieModel {
  final int? id;
  final MainImageModel? mainImage;
  final List<CommonNameModel>? commonNames;
  final String? scientificName;
  final DomainModel? taxdomain;
  final KindomModel? taxkindom;
  final PhylumModel? taxphylum;
  final ClassModel? taxclass;
  final OrderModel? taxorder;
  final FamilyModel? taxfamily;
  final GenusModel? taxgenus;
  final ConservationStatusModel? conservationStatus;
  final EndemismModel? endemism;
  final AbundanceModel? abundance;
  final List<ActivityModel>? activities;
  final List<HabitatModel>? habitats;
  final List<DietModel>? diets;
  final String? description;
  final List<MediaModel>? medias;

  const SpecieModel({
    this.id,
    this.mainImage,
    this.commonNames,
    this.scientificName,
    this.taxdomain,
    this.taxkindom,
    this.taxphylum,
    this.taxclass,
    this.taxorder,
    this.taxfamily,
    this.taxgenus,
    this.conservationStatus,
    this.endemism,
    this.abundance,
    this.activities,
    this.habitats,
    this.diets,
    this.description,
    this.medias,
  });

  factory SpecieModel.fromMap({
    required Map<String, dynamic>? json,
    required MainImageModel? mainImage,
    required List<CommonNameModel>? commonNames,
    required DomainModel? taxdomain,
    required KindomModel? taxkindom,
    required PhylumModel? taxphylum,
    required ClassModel? taxclass,
    required OrderModel? taxorder,
    required FamilyModel? taxfamily,
    required GenusModel? taxgenus,
    required ConservationStatusModel? conservationStatus,
    required EndemismModel? endemism,
    required AbundanceModel? abundance,
    required List<ActivityModel>? activities,
    required List<HabitatModel>? habitats,
    required List<DietModel>? diets,
    required List<MediaModel>? medias,
  }) {
    return SpecieModel(
      id: json!["id"],
      mainImage: mainImage,
      commonNames: commonNames,
      scientificName: json["scientific_name"],
      taxdomain: taxdomain,
      taxkindom: taxkindom,
      taxphylum: taxphylum,
      taxclass: taxclass,
      taxorder: taxorder,
      taxfamily: taxfamily,
      taxgenus: taxgenus,
      conservationStatus: conservationStatus,
      endemism: endemism,
      abundance: abundance,
      activities: activities,
      habitats: habitats,
      diets: diets,
      description: json["description"],
      medias: medias,
    );
  }

  String get commonNamesAsString {
    String _names = '';
    for (var item in commonNames!) {
      _names += '${item.name}\n';
    }
    return _names.substring(0, _names.length - 1);
  }
}
