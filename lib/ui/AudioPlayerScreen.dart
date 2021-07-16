import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';

class AudioPlayerScreen extends StatefulWidget {

  AudioPlayerScreen(this.audioPath);
  String audioPath;

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {

  var _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: 240,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Image.asset(MyImage.audioUrlImage, fit: BoxFit.fill),
              Positioned(
                top: 240/3,
                left: MediaQuery.of(context).size.width*0.42,
                child: StreamBuilder<PlayerState>(
                    stream: _audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          width: 64.0,
                          height: 64.0,
                          child: CircularProgressIndicator(),
                        );
                      } else if (playing != true) {
                        return IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 64.0,
                          onPressed: _audioPlayer.play,
                        );
                      } else {
                        return IconButton(
                          icon: Icon(Icons.pause),
                          iconSize: 64.0,
                          onPressed: _audioPlayer.pause,
                        );
                      }
                    }
                ),
              )
            ],
          )
      ),
    );
  }

  initAudio() async {
    var playList = ConcatenatingAudioSource(
        children: [
          ClippingAudioSource(
              child: AudioSource.uri(Uri.parse(widget.audioPath))
          )
        ]
    );

    _audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      await _audioPlayer.setAudioSource(playList);
    } catch (e) {
      print("Error loading playlist: $e");
    }
  }
}
