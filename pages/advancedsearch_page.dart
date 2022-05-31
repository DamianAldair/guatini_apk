import 'package:flutter/material.dart';
import 'package:guatini/global/main_container.dart';

class AdvancedSearchPage extends StatelessWidget {
  const AdvancedSearchPage({Key? key}) : super(key: key);

  final String pageTitle = 'Búsqueda avanzada';

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: const Center(child: Text('Búsqueda avanzada')),
      ),
    );
  }
}
