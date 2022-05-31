import 'package:flutter/material.dart';
import 'package:guatini/global/main_container.dart';
import 'package:guatini/pages/search_page.dart';
import 'package:guatini/widgets/drawer_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  final String pageTitle = 'Inicio';

  @override
  Widget build(BuildContext context) {
    return AdsContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search_rounded),
              tooltip: 'Buscar',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SimpleSearch(),
                );
              },
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: const Center(
          child: Text('Hello World'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh_rounded),
          tooltip: 'Volver a cargar',
          onPressed: () {},
        ),
      ),
    );
  }
}
