import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenOne extends StatefulWidget {
  String videoPath;
  VideoPlayerScreenOne(this.videoPath);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreenOne> {

  late ChewieController _chewieController;
  late TargetPlatform _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videoPath);
    _chewieController = ChewieController(
      allowFullScreen: true,
      videoPlayerController: _videoPlayerController1,
      aspectRatio: _videoPlayerController1.value.aspectRatio,
      autoPlay: true,
      looping: false,
    );

    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6462AA),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ],
        ),
      );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
