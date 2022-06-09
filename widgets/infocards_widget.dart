import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String field;
  final String instance;

  const InfoCard({
    Key? key,
    required this.field,
    required this.instance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 7.0,
      ),
      height: 40.0,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(field),
          const Text(': '),
          Text(instance),
        ],
      ),
    );
  }
}

class ConservationStateCard extends StatelessWidget {
  const ConservationStateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 7.0,
      ),
      height: 110.0,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: const Text('Estado de conservación'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getConservationIcon(1),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getConservationText(1)),
          ),
        ],
      ),
    );
  }

  String _getConservationText(int index) {
    String conservation = '';
    switch (index) {
      case 1:
        conservation = 'Extinta';
        break;
      case 2:
        conservation = 'Extinta en estado silvestre';
        break;
      case 3:
        conservation = 'En peligro crítico';
        break;
      case 4:
        conservation = 'En peligro';
        break;
      case 5:
        conservation = 'Vulnerable';
        break;
      case 6:
        conservation = 'Casi amenazada';
        break;
      case 7:
        conservation = 'Preocupación menor';
        break;
      case 8:
        conservation = 'Datos insuficientes';
        break;
      case 9:
        conservation = 'No evaluado';
        break;
      default:
        break;
    }
    return conservation;
  }

  List<Widget> _getConservationIcon(int index) {
    List<Widget> list = <Widget>[];
    bool ex = false;
    bool ew = false;
    bool ce = false;
    bool ed = false;
    bool vu = false;
    bool nt = false;
    bool lc = false;

    switch (index) {
      case 1:
        ex = true;
        break;
      case 2:
        ew = true;
        break;
      case 3:
        ce = true;
        break;
      case 4:
        ed = true;
        break;
      case 5:
        vu = true;
        break;
      case 6:
        nt = true;
        break;
      case 7:
        lc = true;
        break;
      default:
        break;
    }
    list.add(_extinct(ex));
    list.add(_extinctInTheWild(ew));
    list.add(_criticalEndangered(ce));
    list.add(_endangered(ed));
    list.add(_vulnerable(vu));
    list.add(_nearThreataned(nt));
    list.add(_leastConcern(lc));
    return list;
  }

  Widget _extinct(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      child: Text(
        'EW',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 207, 52, 52)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _extinctInTheWild(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 0, 0, 0)
            : const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      child: Text(
        'EW',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _criticalEndangered(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 204, 51, 51)
            : const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      child: Text(
        'CE',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 252, 193, 193)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _endangered(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 204, 102, 51)
            : const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      child: Text(
        'EN',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 247, 188, 137)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _vulnerable(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 204, 159, 0)
            : const Color.fromARGB(255, 240, 240, 240),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Text(
        'VU',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _nearThreataned(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 0, 102, 102)
            : const Color.fromARGB(255, 240, 240, 240),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Text(
        'NT',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 113, 177, 140)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _leastConcern(bool active) {
    return Container(
      height: 35.0,
      width: 35.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 0, 102, 102)
            : const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: active
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      child: Text(
        'LC',
        style: TextStyle(
          color: active
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
