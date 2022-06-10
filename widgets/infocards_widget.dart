import 'package:flutter/material.dart';
import 'package:guatini/global/tools.dart' as tools;

enum _InfoCardType {
  normal,
  extended,
}

class InfoCard extends StatelessWidget {
  final String field;
  final String? instance;
  final List<String>? instances;
  final _InfoCardType _infoCardType;

  const InfoCard({
    Key? key,
    required this.field,
    required this.instance,
  })  : _infoCardType = _InfoCardType.normal,
        instances = null,
        super(key: key);

  const InfoCard.extended({
    Key? key,
    required this.field,
    required this.instances,
  })  : _infoCardType = _InfoCardType.extended,
        instance = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 7.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: _infoCardType == _InfoCardType.normal ? 40.0 : null,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _infoCardType == _InfoCardType.normal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(field),
                const Text(': '),
                Flexible(
                  child: Text(
                    instance!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(field),
                      const Text(':'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _convertInstancesToSingleString(),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
    );
  }

  String _convertInstancesToSingleString() {
    String string = '';
    for (String instance in instances!) {
      string += '$instance, ';
    }
    return string.substring(0, string.length - 2);
  }
}

class ConservationStateCard extends StatelessWidget {
  final int index;
  const ConservationStateCard({
    Key? key,
    required this.index,
  })  : assert(index >= 1 || index <= 9, 'Index must be between 1 and 9.'),
        super(key: key);

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
            children: _getConservationIcon(index),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getConservationText(index)),
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
        conservation = 'Error al obtener informnación';
        break;
    }
    return conservation;
  }

  List<Widget> _getConservationIcon(int index) {
    List<Widget> list = <Widget>[];
    if (index >= 1 && index <= 7) {
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
      }
      list.add(_extinct(ex));
      list.add(_extinctInTheWild(ew));
      list.add(_criticalEndangered(ce));
      list.add(_endangered(ed));
      list.add(_vulnerable(vu));
      list.add(_nearThreataned(nt));
      list.add(_leastConcern(lc));
    } else if (index == 8 && index == 9) {
      bool dd = false;
      bool ne = false;
      switch (index) {
        case 8:
          dd = true;
          break;
        case 9:
          ne = true;
          break;
      }
      list.add(_deficientData(dd));
      list.add(_notEvaluated(ne));
    }
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
        'EX',
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

  Widget _deficientData(bool active) {
    return Expanded(
      child: Container(
        height: 35.0,
        width: 35.0,
        margin: const EdgeInsets.only(left: 15.0, right: 8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? const Color.fromARGB(255, 55, 55, 135)
              : const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: active
                ? const Color.fromARGB(0, 0, 0, 0)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        child: Text(
          'DD',
          style: TextStyle(
            color: active
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }

  Widget _notEvaluated(bool active) {
    return Expanded(
      child: Container(
        height: 35.0,
        width: 35.0,
        margin: const EdgeInsets.only(left: 8.0, right: 15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? const Color.fromARGB(255, 55, 55, 135)
              : const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: active
                ? const Color.fromARGB(0, 0, 0, 0)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        child: Text(
          'NE',
          style: TextStyle(
            color: active
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class SoundCard extends StatefulWidget {
  const SoundCard({Key? key}) : super(key: key);

  @override
  State<SoundCard> createState() => _SoundCardState();
}

class _SoundCardState extends State<SoundCard>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _soundController;
  Duration _currentTime = const Duration(microseconds: 0);
  Duration _totalTime = const Duration(seconds: 30);

  @override
  void initState() {
    _soundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 7.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            child: const Text('Sonido:'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  progress: _soundController,
                ),
                onPressed: () {
                  if (!_isPlaying) {
                    _soundController.forward();
                    _isPlaying = true;
                  } else {
                    _soundController.reverse();
                    _isPlaying = false;
                  }
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Slider(
                      value: _currentTime.inMilliseconds.toDouble(),
                      max: _totalTime.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _currentTime = Duration(milliseconds: value.toInt());
                        });
                      },
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 30.0),
                        Text(
                            '${_currentTime.inMinutes}:${tools.convertToTwoDigits(_currentTime.inSeconds)}'),
                        const Expanded(child: SizedBox()),
                        Text(
                            '${_totalTime.inMinutes}:${tools.convertToTwoDigits(_totalTime.inSeconds)}'),
                        const SizedBox(width: 30.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
