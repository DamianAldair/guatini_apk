import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guatini/pages/main_page.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';
import 'package:path_provider/path_provider.dart';

class SelectDbPage extends StatelessWidget {
  final bool? notice;

  const SelectDbPage({
    Key? key,
    this.notice = false,
  }) : super(key: key);

  final String pageTitle = 'Bases de datos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: getExternalStorageDirectory(),
      builder: (BuildContext context, AsyncSnapshot<Directory?> snapshot) {
        if (snapshot.hasData) {
          final List<FileSystemEntity>? _dirList = snapshot.data?.listSync();
          List<Widget> _dbList = [];
          for (FileSystemEntity item in _dirList!) {
            if (item is Directory && _dbExist(item)) {
              List<String> _splitPath = item.path.split('/');
              final _prefs = UserPreferences();
              _dbList.add(ListTile(
                leading: const Icon(Icons.menu_book_rounded),
                title: Text(_splitPath.last),
                trailing: _prefs.dbPath == '${item.path}/'
                    ? const Icon(Icons.radio_button_checked_rounded)
                    : const Icon(Icons.radio_button_off_rounded),
                onTap: () {
                  _prefs.dbPath = '${item.path}/';
                  Navigator.pushNamed(context, '/main');
                },
              ));
            }
          }
          if (_dbList.isNotEmpty) {
            return ListView(children: _dbList);
          } else {
            return const Center(
                child: Text('No se encontraron bases de datos'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  bool _dbExist(Directory dir) {
    try {
      List<FileSystemEntity> _list = Directory('${dir.path}/db').listSync();
      for (FileSystemEntity item in _list) {
        if (item is File) {
          List<String> _splitPath = item.path.split('/');
          if (_splitPath.last == 'db_guatini.db') {
            return true;
          }
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
