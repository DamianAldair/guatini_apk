import 'package:flutter/material.dart';
import 'package:guatini/global/appdata.dart' as app_data;
import 'package:guatini/global/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _drawerList(context),
      ),
    );
  }

  List<Widget> _drawerList(BuildContext context) {
    List<Widget> drawerList = <Widget>[];
    drawerList.add(
      DrawerHeader(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawer_header.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomRight,
          child: const Text(
            app_data.title,
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 255, 255, 255),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
    for (var _pageRoute in drawerPagesRoutes) {
      drawerList.add(ListTile(
        leading: Icon(
          _pageRoute.icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(_pageRoute.title),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => _pageRoute.page));
        },
      ));
    }
    return drawerList;
  }
}
