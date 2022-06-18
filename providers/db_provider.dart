import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guatini/global/tools.dart' as tools;
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
import 'package:guatini/models/mediatype_model.dart';
import 'package:guatini/models/order_model.dart';
import 'package:guatini/models/phylum_model.dart';
import 'package:guatini/models/specie_model.dart';

class DBProvider {
  static Database? _database;
  DBProvider._privateConst();
  static final DBProvider instance = DBProvider._privateConst();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _checkPermission();
    return _database;
  }

  Future<Database?> _checkPermission() async {
    bool status = await tools.getStoragePermission();
    if (status) return _initiateDatabase();
    return null;
  }

  Future<Database> _initiateDatabase() async {
    Directory? _dir = await getExternalStorageDirectory();
    String _path = join(_dir!.path, tools.dbPath);
    final _prefs = UserPreferences();
    _prefs.dbPath = _path.substring(0, _path.length - 16);
    return await openDatabase(
      _path,
      version: 1,
      onCreate: (Database db, int version) async {
        debugPrint(db.path);
      },
    );
  }

  Future<MainImageModel?> _getMainImage(Database db, int specieId) async {
    final _query = 'select '
        '[main].[media].[id], '
        '[main].[media].[path], '
        '[main].[media].[date_capture], '
        '[main].[media].[lat], '
        '[main].[media].[lon]'
        'from   [main].[specie]'
        'inner join [main].[media] on [main].[specie].[id] = [main].[media].[fk_specie_]'
        'inner join [main].[main_image] on [main].[media].[id] = [main].[main_image].[fk_media_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _media =
        _result.isNotEmpty ? MainImageModel.fromMap(_result.first) : null;
    return _media;
  }

  Future<List<CommonNameModel>> _getCommonNames(
      Database db, int specieId) async {
    final _query = 'select '
        '[main].[common_name].[id], '
        '[main].[common_name].[name]'
        'from   [main].[specie]'
        'inner join [main].[common_name] on [main].[specie].[id] = [main].[common_name].[fk_specie_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _commonNames = <CommonNameModel>[];
    for (var item in _result) {
      _commonNames.add(CommonNameModel.fromMap(item));
    }
    return _commonNames;
  }

  Future<GenusModel?> _getGenus(Database db, int? specieId) async {
    final _query = 'select '
        '[main].[t_genus].[id], '
        '[main].[t_genus].[name], '
        '[main].[t_genus].[description]'
        'from   [main].[specie]'
        'inner join [main].[t_genus] on [main].[t_genus].[id] = [main].[specie].[fk_t_genus_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = specieId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? GenusModel.fromMap(_result.first) : null;
  }

  Future<FamilyModel?> _getFamily(Database db, int? genusId) async {
    final _query = 'select '
        '[main].[t_family].[id], '
        '[main].[t_family].[name], '
        '[main].[t_family].[description]'
        'from   [main].[t_genus]'
        'inner join [main].[t_family] on [main].[t_family].[id] = [main].[t_genus].[fk_t_family_]'
        'where [main].[t_genus].[id] = $genusId;';
    final _result = genusId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? FamilyModel.fromMap(_result.first) : null;
  }

  Future<OrderModel?> _getOrder(Database db, int? familyId) async {
    final _query = 'select '
        '[main].[t_order].[id], '
        '[main].[t_order].[name], '
        '[main].[t_order].[description]'
        'from   [main].[t_family]'
        'inner join [main].[t_order] on [main].[t_order].[id] = [main].[t_family].[fk_t_order_]'
        'where [main].[t_family].[id] = $familyId;';
    final _result = familyId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? OrderModel.fromMap(_result.first) : null;
  }

  Future<ClassModel?> _getClass(Database db, int? orderId) async {
    final _query = 'select '
        '[main].[t_class].[id], '
        '[main].[t_class].[name], '
        '[main].[t_class].[description]'
        'from   [main].[t_order]'
        'inner join [main].[t_class] on [main].[t_class].[id] = [main].[t_order].[fk_t_class_]'
        'where [main].[t_order].[id] = $orderId;';
    final _result = orderId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? ClassModel.fromMap(_result.first) : null;
  }

  Future<PhylumModel?> _getPhylum(Database db, int? classId) async {
    final _query = 'select '
        '[main].[t_phylum].[id], '
        '[main].[t_phylum].[name], '
        '[main].[t_phylum].[description]'
        'from   [main].[t_class]'
        'inner join [main].[t_phylum] on [main].[t_phylum].[id] = [main].[t_class].[fk_t_phylum_]'
        'where [main].[t_class].[id] = $classId;';
    final _result = classId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? PhylumModel.fromMap(_result.first) : null;
  }

  Future<KindomModel?> _getKindom(Database db, int? phylumId) async {
    final _query = 'select '
        '[main].[t_kindom].[id], '
        '[main].[t_kindom].[name], '
        '[main].[t_kindom].[description]'
        'from   [main].[t_phylum]'
        'inner join [main].[t_kindom] on [main].[t_kindom].[id] = [main].[t_phylum].[fk_t_kindom_]'
        'where [main].[t_phylum].[id] = $phylumId;';
    final _result = phylumId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? KindomModel.fromMap(_result.first) : null;
  }

  Future<DomainModel?> _getDomain(Database db, int? kindomId) async {
    final _query = 'select '
        '[main].[t_domain].[id], '
        '[main].[t_domain].[name], '
        '[main].[t_domain].[description]'
        'from   [main].[t_kindom]'
        'inner join [main].[t_domain] on [main].[t_domain].[id] = [main].[t_kindom].[fk_t_domain_]'
        'where [main].[t_kindom].[id] = $kindomId;';
    final _result = kindomId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? DomainModel.fromMap(_result.first) : null;
  }

  Future<ConservationStatusModel?> _getConservationStatus(
      Database db, int? specieId) async {
    final _query = 'select '
        '[main].[coservation_status].[id], '
        '[main].[coservation_status].[status]'
        'from   [main].[specie]'
        'inner join [main].[coservation_status] on [main].[coservation_status].[id] = [main].[specie].[fk_coservation_status_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = specieId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty
        ? ConservationStatusModel.fromMap(_result.first)
        : null;
  }

  Future<EndemismModel?> _getEndemism(Database db, int? specieId) async {
    final _query = 'select '
        '[main].[endemism].[id], '
        '[main].[endemism].[zone]'
        'from   [main].[specie]'
        'inner join [main].[endemism] on [main].[endemism].[id] = [main].[specie].[fk_endemism_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = specieId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? EndemismModel.fromMap(_result.first) : null;
  }

  Future<AbundanceModel?> _getAbundance(Database db, int? specieId) async {
    final _query = 'select '
        '[main].[abundance].[id], '
        '[main].[abundance].[abundance]'
        'from   [main].[specie]'
        'inner join [main].[abundance] on [main].[abundance].[id] = [main].[specie].[fk_abundance_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = specieId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? AbundanceModel.fromMap(_result.first) : null;
  }

  Future<List<ActivityModel>> _getActivities(Database db, int specieId) async {
    final _query = 'select '
        '[main].[activity].[id], '
        '[main].[activity].[activity]'
        'from   [main].[specie]'
        'inner join [main].[specie_activity] on [main].[specie].[id] = [main].[specie_activity].[fk_specie_]'
        'inner join [main].[activity] on [main].[activity].[id] = [main].[specie_activity].[fk_activity_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _activities = <ActivityModel>[];
    for (var item in _result) {
      _activities.add(ActivityModel.fromMap(item));
    }
    return _activities;
  }

  Future<List<HabitatModel>> _getHabitats(Database db, int specieId) async {
    final _query = 'select '
        '[main].[habitat].[id], '
        '[main].[habitat].[habitat]'
        'from   [main].[specie]'
        'inner join [main].[specie_habitat] on [main].[specie].[id] = [main].[specie_habitat].[fk_specie_]'
        'inner join [main].[habitat] on [main].[habitat].[id] = [main].[specie_habitat].[fk_habitat_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _habitats = <HabitatModel>[];
    for (var item in _result) {
      _habitats.add(HabitatModel.fromMap(item));
    }
    return _habitats;
  }

  Future<List<DietModel>> _getDiets(Database db, int specieId) async {
    final _query = 'select '
        '[main].[diet].[id], '
        '[main].[diet].[diet]'
        'from   [main].[specie]'
        'inner join [main].[specie_diet] on [main].[specie].[id] = [main].[specie_diet].[fk_specie_]'
        'inner join [main].[diet] on [main].[diet].[id] = [main].[specie_diet].[fk_diet_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _diets = <DietModel>[];
    for (var item in _result) {
      _diets.add(DietModel.fromMap(item));
    }
    return _diets;
  }

  Future<List<MediaModel>> _getMedias(Database db, int specieId) async {
    final _query = 'select '
        '[main].[media].[id], '
        '[main].[media].[path], '
        '[main].[media].[date_capture], '
        '[main].[media].[lat], '
        '[main].[media].[lon], '
        '[main].[media].[fk_type_]'
        'from   [main].[media]'
        'inner join [main].[specie] on [main].[specie].[id] = [main].[media].[fk_specie_]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await db.rawQuery(_query);
    final _medias = <MediaModel>[];
    for (Map<String, Object?> item in _result) {
      MediaTypeModel? _type =
          await _getMediaType(db, MediaModel.fromMap(item).id);
      MediaModel _media = MediaModel.fromMap(item);
      _media.type = _type;
      _medias.add(_media);
    }
    return _medias;
  }

  Future<MediaTypeModel?> _getMediaType(Database db, int? mediaId) async {
    final _query = 'select '
        '[main].[type].[id], '
        '[main].[type].[type]'
        'from   [main].[media]'
        'inner join [main].[type] on [main].[type].[id] = [main].[media].[fk_type_]'
        'where [main].[media].[id] = $mediaId;';
    final _result = mediaId != null ? await db.rawQuery(_query) : [];
    return _result.isNotEmpty ? MediaTypeModel.fromMap(_result.first) : null;
  }

  Future<SpecieModel?> getSpecie(int specieId) async {
    final _db = await database;
    final _query = 'select '
        '[main].[specie].[id], '
        '[main].[specie].[scientific_name], '
        '[main].[specie].[description]'
        'from   [main].[specie]'
        'where [main].[specie].[id] = $specieId;';
    final _result = await _db!.rawQuery(_query);
    final _mainImage = await _getMainImage(_db, specieId);
    final _commonNames = await _getCommonNames(_db, specieId);
    final _taxgenus = await _getGenus(_db, specieId);
    final _taxfamily = await _getFamily(_db, _taxgenus!.id);
    final _taxorder = await _getOrder(_db, _taxfamily!.id);
    final _taxclass = await _getClass(_db, _taxorder!.id);
    final _taxphylum = await _getPhylum(_db, _taxclass!.id);
    final _taxkindom = await _getKindom(_db, _taxphylum!.id);
    final _taxdomain = await _getDomain(_db, _taxkindom!.id);
    final _conservationStatus = await _getConservationStatus(_db, specieId);
    final _endemism = await _getEndemism(_db, specieId);
    final _abundance = await _getAbundance(_db, specieId);
    final _activities = await _getActivities(_db, specieId);
    final _habitats = await _getHabitats(_db, specieId);
    final _diets = await _getDiets(_db, specieId);
    final _medias = await _getMedias(_db, specieId);
    return SpecieModel.fromMap(
      json: _result.first,
      mainImage: _mainImage,
      commonNames: _commonNames,
      taxdomain: _taxdomain,
      taxkindom: _taxkindom,
      taxphylum: _taxphylum,
      taxclass: _taxclass,
      taxorder: _taxorder,
      taxfamily: _taxfamily,
      taxgenus: _taxgenus,
      conservationStatus: _conservationStatus,
      endemism: _endemism,
      abundance: _abundance,
      activities: _activities,
      habitats: _habitats,
      diets: _diets,
      medias: _medias,
    );
  }
}
