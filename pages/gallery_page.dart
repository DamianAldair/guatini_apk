import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guatini/models/media_model.dart';
import 'package:guatini/global/tools.dart' as tools;
import 'package:guatini/models/mediatype_model.dart';
import 'package:guatini/providers/sharedpreferences_provider.dart';
import 'package:video_player/video_player.dart';

class GalleryPage extends StatelessWidget {
  final MediaModel? media;

  const GalleryPage({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _prefs = UserPreferences();
    final _dbPath = _prefs.dbPath;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: File('$_dbPath${media!.path}').exists(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return media!.mediaType.type == MediaType.image
                  ? _ImageViewer(media: media)
                  : _VideoViewer(media: media);
            } else {
              return const _NoMediaViewer();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final MediaModel? media;

  const _ImageViewer({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          InteractiveViewer(
            maxScale: 10.0,
            child: Center(
              child: Hero(
                tag: media!.id!,
                child: tools.getImage(media!.path),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                tooltip: 'Atrás',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Imagen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(Icons.info_outlined),
                color: Colors.white,
                tooltip: 'Información de la imagen',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VideoViewer extends StatefulWidget {
  final MediaModel? media;

  const _VideoViewer({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  State<_VideoViewer> createState() => __VideoViewerState();
}

class __VideoViewerState extends State<_VideoViewer> {
  late VideoPlayerController _videoController;
  bool showControls = true;

  @override
  void initState() {
    super.initState();
    final _prefs = UserPreferences();
    final _dbPath = _prefs.dbPath;
    _videoController = VideoPlayerController.file(
      File('$_dbPath${widget.media!.path!}'),
    );
    _videoController.addListener(() => setState(() {}));
    _videoController.initialize().then((value) => setState(() {}));
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () => setState(() => showControls = !showControls),
              child: Hero(
                tag: widget.media!.id!,
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          ),
          showControls
              ? Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(100, 0, 0, 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_sharp),
                            color: Colors.white,
                            tooltip: 'Atrás',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            icon: const Icon(Icons.info_outlined),
                            color: Colors.white,
                            tooltip: 'Información del video',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      color: const Color.fromARGB(100, 0, 0, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  _videoController.value.position
                                      .toString()
                                      .split('.')[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                  activeColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  inactiveColor:
                                      const Color.fromARGB(100, 255, 255, 255),
                                  max: _videoController
                                      .value.duration.inMilliseconds
                                      .toDouble(),
                                  value: _videoController
                                      .value.position.inMilliseconds
                                      .toDouble(),
                                  onChanged: (double value) {
                                    _videoController.seekTo(
                                        Duration(milliseconds: value.toInt()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  _videoController.value.duration
                                      .toString()
                                      .split('.')[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              IconButton(
                                icon: const Icon(Icons.skip_previous),
                                color: Colors.white,
                                tooltip: 'Comenzar reproducción de nuevo',
                                onPressed: () {
                                  setState(() {
                                    _videoController
                                        .seekTo(const Duration(seconds: 0));
                                    if (!_videoController.value.isPlaying) {
                                      _videoController.play();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 20.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                height: 50.0,
                                width: 50.0,
                                child: IconButton(
                                  icon: Icon(_videoController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  color: Colors.black,
                                  tooltip: _videoController.value.isPlaying
                                      ? 'Pausar'
                                      : 'Reproducir',
                                  onPressed: () {
                                    setState(() {
                                      _videoController.value.isPlaying
                                          ? _videoController.pause()
                                          : _videoController.play();
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              IconButton(
                                icon: const Icon(Icons.stop),
                                color: Colors.white,
                                tooltip: 'Parar reproducción',
                                onPressed: () {
                                  setState(() {
                                    _videoController
                                        .seekTo(const Duration(seconds: 0));
                                    if (_videoController.value.isPlaying) {
                                      _videoController.pause();
                                    }
                                  });
                                },
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    VideoProgressIndicator(
                      _videoController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Color.fromARGB(100, 255, 255, 255),
                        backgroundColor: Color.fromARGB(80, 255, 255, 255),
                        bufferedColor: Color.fromARGB(100, 165, 165, 165),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _NoMediaViewer extends StatelessWidget {
  const _NoMediaViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/image_not_available.png'),
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    tooltip: 'Atrás',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 30.0,
                ),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(150, 220, 220, 220),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Hubo un error al tratar de cargar el elemento multimedia. Puede que haya sido borrado o movido.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
