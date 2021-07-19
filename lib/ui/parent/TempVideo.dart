import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../VideoPlayer.dart';
class TempVideo extends StatefulWidget {
  @override
  _TempVideoState createState() => _TempVideoState();
}

class _TempVideoState extends State<TempVideo> {

  late bool isPortrait;
  late VideoPlayerController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
       /* resizeToAvoidBottomInset: false,
        body: Dismissible(
        key: const Key('key'),
    direction: DismissDirection.vertical,
    onDismissed: (_) => Navigator.of(context).pop(),
    child: OrientationBuilder(
    builder: (context, orientation) {
    isPortrait = orientation == Orientation.portrait;
    return Center(
    child: Stack(
    //This will help to expand video in Horizontal mode till last pixel of screen
    fit: isPortrait ? StackFit.loose : StackFit.expand,
    children: [
    AspectRatio(
    aspectRatio: _controller.value.aspectRatio,
    child: VideoPlayer(_controller),
    ),
    ],
    ),
    );
    },
    );
  },
  ),
  }*/
}
