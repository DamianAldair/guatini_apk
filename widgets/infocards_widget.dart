import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:guatini/models/mediatype_model.dart';
import 'package:guatini/pages/gallery_page.dart';
import 'package:path/path.dart';
import 'package:guatini/global/tools.dart' as tools;
import 'package:guatini/models/conservationstatus_model.dart';
import 'package:guatini/models/media_model.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';

enum _InfoCardType {
  normal,
  extended,
}

class InfoCard<T> extends StatelessWidget {
  final String field;
  final T? instance;
  final List<T>? instances;
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
                    instance.toString(),
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
                    tools.instancesToString(instances!),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
    );
  }
}

class ConservationStateCard extends StatelessWidget {
  final ConservationStatusModel? status;
  const ConservationStateCard({
    Key? key,
    required this.status,
  }) : super(key: key);

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
            children: _getConservationIcon(status!.status),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getConservationText(status!.status)),
          ),
        ],
      ),
    );
  }

  String _getConservationText(int? index) {
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

  List<Widget> _getConservationIcon(int? index) {
    List<Widget> list = <Widget>[];
    if (index! >= 1 && index <= 7) {
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
  final List<MediaModel>? medias;
  const SoundCard({
    Key? key,
    required this.medias,
  }) : super(key: key);

  @override
  State<SoundCard> createState() => _SoundCardState();
}

class _SoundCardState extends State<SoundCard>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _soundController;
  late AudioPlayer _soundPlayer;
  Duration _position = const Duration();
  Duration _duration = const Duration();

  @override
  void initState() {
    _soundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _soundPlayer = AudioPlayer();
    initAudio();
    super.initState();
  }

  @override
  void dispose() {
    _soundController.dispose();
    _soundPlayer.dispose();
    super.dispose();
  }

  void initAudio() {
    _soundPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    _soundPlayer.onPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });
    _soundPlayer.onPlayerComplete.listen((event) {
      _soundController.reverse();
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = UserPreferences();
    String? _audioPath = _prefs.dbPath;
    for (MediaModel item in widget.medias!) {
      if (item.mediaType.type == MediaType.audio) {
        _audioPath = join(_audioPath!, item.path);
        break;
      }
    }
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
        child: FutureBuilder(
          future: File(_audioPath!).exists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                _soundPlayer.setSource(UrlSource(_audioPath!));
                return Column(
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
                              _soundPlayer.play(UrlSource(_audioPath!));
                            } else {
                              _soundController.reverse();
                              _isPlaying = false;
                              _soundPlayer.pause();
                            }
                          },
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Slider.adaptive(
                                value: _position.inMilliseconds.toDouble(),
                                max: _duration.inMilliseconds.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    _soundPlayer.seek(
                                        Duration(milliseconds: value.toInt()));
                                    _position =
                                        Duration(milliseconds: value.toInt());
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 30.0),
                                  Text(_duration != Duration.zero
                                      ? '${_position.inMinutes}:${tools.convertToTwoDigits(_position.inSeconds)}'
                                      : ''),
                                  const Expanded(child: SizedBox()),
                                  Text(_duration != Duration.zero
                                      ? '${_duration.inMinutes}:${tools.convertToTwoDigits(_duration.inSeconds)}'
                                      : ''),
                                  const SizedBox(width: 30.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          bottom: 30.0,
                          left: 10.0,
                          right: 20.0,
                        ),
                        child: Image.asset(
                            'assets/images/sound_not_available.png'),
                      ),
                      const Flexible(
                        child: Text(
                          'Al parecer hay problemas al encontar al archivo de audio.',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class Description extends StatelessWidget {
  final String description;
  const Description({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class GalleryCard extends StatelessWidget {
  final List<MediaModel>? medias;

  const GalleryCard({
    Key? key,
    required this.medias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MediaModel> _gallery = [];
    for (var item in medias!) {
      if (item.mediaType.type != MediaType.audio) {
        _gallery.add(item);
      }
    }
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 10.0,
          ),
          child: Text(
            'Galería',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.6,
            ),
            pageSnapping: false,
            itemCount: _gallery.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  child: Hero(
                    tag: _gallery[i].id!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: tools.getThumbnail(_gallery[i]),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryPage(media: _gallery[i])));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
