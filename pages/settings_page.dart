import 'package:flutter/material.dart';
import 'package:guatini/pages/selectdb_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  final String pageTitle = 'Configuración';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: _body(context),
    );
  }

  ListView _body(BuildContext context) {
    return ListView(
      children: [
        const Divider(),
        ListTile(
          leading: const Icon(Icons.library_books_rounded),
          title: const Text('Seleccionar Base de Datos'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectDbPage()));
          },
        ),
        const Divider(),
      ],
    );
  }
}
