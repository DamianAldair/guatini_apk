import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guatini/global/tools.dart' as tools;
import 'package:guatini/models/specie_model.dart';
import 'package:guatini/providers/db_provider.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';
import 'package:guatini/widgets/infocards_widget.dart';

class SpecieDetailPage extends StatelessWidget {
  final int specieId;

  const SpecieDetailPage(this.specieId, {Key? key}) : super(key: key);

  final String pageTitle = 'Detalles de la especie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: _myBody(),
    );
  }

  Widget _myBody() {
    return FutureBuilder(
      future: DBProvider.instance.getSpecie(1),
      builder: (BuildContext context, AsyncSnapshot<SpecieModel?> snapshot) {
        if (snapshot.hasData) {
          final specie = snapshot.data;
          try {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: _getMainImage(specie),
                    ),
                  ),
                  Text(
                    specie!.commonNamesAsString,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text('${specie.scientificName}'),
                  const SizedBox(height: 10.0),
                  InfoCard(field: 'Dominio', instance: specie.taxdomain),
                  InfoCard(field: 'Reino', instance: specie.taxkindom),
                  InfoCard(field: 'Filo', instance: specie.taxphylum),
                  InfoCard(field: 'Clase', instance: specie.taxclass),
                  InfoCard(field: 'Orden', instance: specie.taxorder),
                  InfoCard(field: 'Familia', instance: specie.taxfamily),
                  InfoCard(field: 'Gérero', instance: specie.taxgenus),
                  ConservationStateCard(status: specie.conservationStatus),
                  InfoCard(field: 'Endemismo', instance: specie.endemism),
                  InfoCard(field: 'Abundancia', instance: specie.abundance),
                  InfoCard.extended(
                      field: 'Actividad', instances: specie.activities),
                  InfoCard.extended(
                      field: 'Hábitat', instances: specie.habitats),
                  InfoCard.extended(field: 'Dieta', instances: specie.diets),
                  SoundCard(medias: specie.medias),
                  Description(description: '${specie.description}'),
                  const Gallery(),
                  const SizedBox(height: 10.0),
                ],
              ),
            );
          } catch (e) {
            return _dbErrorScreen;
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget get _dbErrorScreen {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(tools.warningDB),
      ),
    );
  }

  _getMainImage(SpecieModel? specie) {
    final _mediaModel = specie!.mainImage;
    final _prefs = UserPreferences();
    final _dbPath = _prefs.dbPath;
    return _mediaModel == null
        ? const AssetImage('assets/images/image_not_available.png')
        : FutureBuilder(
            future: File('$_dbPath${_mediaModel.path}').exists(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data) {
                  return Image.file(File('$_dbPath${_mediaModel.path}'));
                } else {
                  return Image.asset('assets/images/image_not_available.png');
                }
              } else {
                return Image.asset('assets/images/loading.gif');
              }
            },
          );
  }
}
