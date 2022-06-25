import 'package:flutter/material.dart';
import 'package:guatini/models/specie_search_model.dart';
import 'package:guatini/pages/speciedetail_page.dart';
import 'package:guatini/providers/db_provider.dart';
import 'package:guatini/global/tools.dart' as tools;
import 'package:guatini/providers/sharedpreferences_provider.dart';

class SimpleSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar especie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        tooltip: 'Borrar todo',
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: 'Volver',
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      final _prefs = UserPreferences();
      final _lastSearch = _prefs.last5Searches!.reversed.toList();
      return ListView.builder(
        itemCount: _lastSearch.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            leading: const Icon(Icons.access_time_rounded),
            title: Text(_lastSearch[i]),
            onTap: () {
              query = _lastSearch[i];
            },
          );
        },
      );
    }
    return FutureBuilder(
      future: DBProvider.instance.searchSpecie(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<SpecieFromSimpleSearch>> snapshot) {
        if (snapshot.hasData) {
          final _results = snapshot.data;
          return ListView.builder(
            itemCount: _results!.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                leading: SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: _results[i].image,
                  ),
                ),
                title: tools.getSearchedText(_results[i].name!, query),
                subtitle:
                    tools.getSearchedText(_results[i].scientificName!, query),
                onTap: () {
                  final _prefs = UserPreferences();
                  _prefs.newSearch(query);
                  close(context, null);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpecieDetailPage(_results[i].id!)));
                },
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
