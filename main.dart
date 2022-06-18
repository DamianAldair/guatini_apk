import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:guatini/global/appdata.dart' as app_data;
import 'package:guatini/global/tools.dart' as tools;
import 'package:guatini/pages/main_page.dart';
import 'package:guatini/pages/selectdb_page.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  UserPreferences prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_data.productName,
      home: tools.checkDB(),
      routes: {
        '/main': (BuildContext context) => const MainPage(),
        '/selectdb': (BuildContext context) => const SelectDbPage(),
      },
    );
  }
}
