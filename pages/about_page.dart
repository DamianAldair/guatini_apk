import 'package:flutter/material.dart';
import 'package:guatini/global/appdata.dart' as app_data;

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final String pageTitle = 'Acerca de...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          _background(),
          _content(context),
        ],
      ),
    );
  }

  Container _background() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromARGB(0, 0, 0, 0),
            Color.fromARGB(200, 0, 0, 0),
          ],
        ),
      ),
    );
  }

  ListView _content(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        const SizedBox(height: 30.0),
        const Center(
          child: Text(
            app_data.title,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 30.0,
            ),
          ),
        ),
        const Center(
          child: Text(
            'Versión ${app_data.version}',
            style: TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: _size.width * 0.35,
            height: _size.width * 0.35,
            child: Image.asset('assets/icons/android_icon.png'),
          ),
        ),
        Center(
          child: Text(
            app_data.copyright,
            style: const TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: const Text(
              'Desarrollado por: ${app_data.developer}',
              style: TextStyle(
                color: Color.fromARGB(150, 255, 255, 255),
              ),
            ),
          ),
        ),
        SizedBox(
          width: _size.width * 0.1,
          height: _size.width * 0.15,
          child: Image.asset('assets/images/logo_cujae.png'),
        ),
        const Text(
          '${app_data.department}\n\n${app_data.organization}\n\n${app_data.organizationLite}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(150, 255, 255, 255),
          ),
        ),
      ],
    );
    /* return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            app_data.title,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 30.0,
            ),
          ),
          const Text(
            'Versión ${app_data.version}',
            style: TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ),
          SizedBox(
            width: _size.width * 0.35,
            height: _size.width * 0.45,
            child: Image.asset('assets/icons/android_icon.png'),
          ),
          Text(
            app_data.copyright,
            style: const TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: const Text(
              'Desarrollado por: ${app_data.developer}',
              style: TextStyle(
                color: Color.fromARGB(150, 255, 255, 255),
              ),
            ),
          ),
          SizedBox(
            width: _size.width * 0.1,
            height: _size.width * 0.15,
            child: Image.asset('assets/images/logo_cujae.png'),
          ),
          const Text(
            '${app_data.department}\n\n${app_data.organization}\n\n${app_data.organizationLite}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ),
        ],
      ),
    ); */
  }
}
