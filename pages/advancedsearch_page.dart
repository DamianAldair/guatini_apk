import 'package:flutter/material.dart';

class AdvancedSearchPage extends StatelessWidget {
  const AdvancedSearchPage({Key? key}) : super(key: key);

  final String pageTitle = 'Búsqueda avanzada';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: const Center(child: Text('Búsqueda avanzada')),
    );
  }
}
