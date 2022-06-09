import 'package:flutter/material.dart';
import 'package:guatini/widgets/infocards_widget.dart';

class SpecieDetailPage extends StatelessWidget {
  const SpecieDetailPage({Key? key}) : super(key: key);

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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: const FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                placeholderFit: BoxFit.cover,
                image: AssetImage('assets/images/image_not_available.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 100),
                fadeOutDuration: Duration(milliseconds: 100),
              ),
            ),
          ),
          const Text(
            'Nombre común',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text('Nombre científico'),
          const SizedBox(height: 10.0),
          const InfoCard(field: 'Dominio', instance: 'd'),
          const InfoCard(field: 'Reino', instance: 'r'),
          const InfoCard(field: 'Filo', instance: 'f'),
          const InfoCard(field: 'Clase', instance: 'c'),
          const InfoCard(field: 'Orden', instance: 'o'),
          const InfoCard(field: 'Familia', instance: 'f'),
          const InfoCard(field: 'Gérero', instance: 'g'),
          const ConservationStateCard(),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
