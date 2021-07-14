import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:video_player/video_player.dart';
import 'package:volume/volume.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerScreen extends StatefulWidget {

  VideoPlayerScreen(this.videoUrl);
  String videoUrl;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  var showInstructions = false;
  int currentVol = 0;
  int skipDuration = 10;

  double _playedValue = 0.0;
  double _bufferedValue = 0.0;

  bool noForward = false;
  bool _touchDown = false;
  bool _userTouchedToScreen = false;

  Offset _touchPoint = Offset.zero;
  String _currentPositionString = "", _remainingString = "";

  @override
  void initState() {
    super.initState();

    initAudioStreamType();
    setVol(1);
    Wakelock.enable();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        showInstructions = _controller.value.aspectRatio >= 1;
        setState(() {
          _controller.play();
        });

        if (showInstructions) {
          Future.delayed(Duration(seconds: 5)).then((onValue) {
            showInstructions = false;
          });
        }
      });
    _controller.addListener(videoCallback);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }

  void positionListener() {
    int? _totalDuration = _controller.value.duration.inMilliseconds;
    print("positionListener duration: $_totalDuration");
    if (mounted && _totalDuration != null && _totalDuration != 0) {
      setState(() {
        _playedValue =
            _controller.value.position.inMilliseconds / _totalDuration;
        _bufferedValue = _controller.value.buffered as double;
      });
    }
  }

  void _setValue() {
    _playedValue = _touchPoint.dx / context.size!.width;
  }

  void _checkTouchPoint() {
    if (_touchPoint.dx <= 0) {
      _touchPoint = Offset(0, _touchPoint.dy);
    }
    if (_touchPoint.dx >= context.size!.width) {
      _touchPoint = Offset(context.size!.width, _touchPoint.dy);
    }
  }

  Offset _getTouchPoint(Offset touchPoint) {
    if (touchPoint.dx <= 0) {
      touchPoint = Offset(0, touchPoint.dy);
    }
    if (touchPoint.dx >= context.size!.width) {
      touchPoint = Offset(context.size!.width, touchPoint.dy);
    }
    return touchPoint;
  }

  void _seekToRelativePosition(Offset globalPosition) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    Offset touchPoint = box!.globalToLocal(globalPosition);
    touchPoint = _getTouchPoint(touchPoint);
    final double relative = touchPoint.dx / box.size.width;
    final Duration position = _controller.value.duration * relative;
    int diff = position.compareTo(_controller.value.position);
    bool isForward = diff > 0;
    if (noForward && isForward) {
      print("Sorry, you can't fast-forward");
      setState(() => _touchDown = false);
    } else {
      _touchPoint = touchPoint;
      _checkTouchPoint();
      _controller.seekTo(position);
    }
  }

  Widget videoProgressBar() {
    return GestureDetector(
      onHorizontalDragDown: (details) {
        setState(() {
          _setValue();
          _touchDown = true;
        });
        _seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _setValue();
        });
        _seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          _touchDown = false;
          _setValue();
        });
        _seekToRelativePosition(_touchPoint);
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 15.0),
        child: CustomPaint(
          painter: ProgressBarPainter(
            progressWidth: 3.0,
            handleRadius: 7.0,
            playedValue: _playedValue,
            bufferedValue: _bufferedValue,
            touchDown: _touchDown,
            themeData: Theme.of(context),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: <Widget>[
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange),
                          backgroundColor: HexColor("#6462AA"),
                        ),
                      ),
              ),
              GestureDetector(
                child: _userTouchedToScreen
                    ? Container(
                        margin: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            videoProgressBar(),
                            SizedBox(height: 7),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  color: Colors.transparent,
                                  child: Text(_currentPositionString,
                                      style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, Colors.white)),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RaisedButton(
                                          padding: EdgeInsets.all(6.0),
                                          color: Colors.transparent,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              setState(() {
                                                var backwordDuration =
                                                    _controller.value.position
                                                            .inSeconds -
                                                        skipDuration;
                                                if (_controller.value.position
                                                        .inSeconds >=
                                                    0) {
                                                  _controller.seekTo(Duration(
                                                      seconds:
                                                          backwordDuration));
                                                }
                                              });
                                            });
                                          },
                                          child: Icon(Icons.fast_rewind,
                                              size: 25)),
                                      RaisedButton(
                                          padding: EdgeInsets.all(6.0),
                                          color: Colors.transparent,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              _controller.value.isPlaying
                                                  ? _controller.pause()
                                                  : _controller.play();
                                            });
                                          },
                                          child: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 25)),
                                      RaisedButton(
                                          padding: EdgeInsets.all(6.0),
                                          color: Colors.transparent,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              var remainDuration = _controller
                                                      .value
                                                      .duration
                                                      .inSeconds -
                                                  _controller
                                                      .value.position.inSeconds;
                                              if (remainDuration >= 1) {
                                                if (remainDuration < 9) {
                                                  var forwordDuration =
                                                      remainDuration - 1;
                                                  _controller.seekTo(Duration(
                                                      seconds:
                                                          forwordDuration));
                                                } else {
                                                  var forwordDuration =
                                                      _controller.value.position
                                                              .inSeconds +
                                                          skipDuration;
                                                  _controller.seekTo(Duration(
                                                      seconds:
                                                          forwordDuration));
                                                }
                                              }
                                            });
                                          },
                                          child: Icon(Icons.fast_forward,
                                              size: 25))
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  color: Colors.transparent,
                                  child: Text(_remainingString,
                                      style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, Colors.white)),
                                ),
                                SizedBox(width: 10),
                              ],
                            )
                          ],
                        ))
                    : Container(),
                behavior: HitTestBehavior.translucent,
                onTapDown: (tapdown) {
                  setState(() {
                    _userTouchedToScreen = true;
                    Future.delayed(Duration(seconds: 5)).then((value) {
                      _userTouchedToScreen = false;
                    });
                  });
                },
              ),
              SafeArea(
                child:  BackButton(
                        color: Colors.white,
                        onPressed: () {
                          _controller.pause();
                          Navigator.pop(context);
                        },
                      ),

              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Wakelock.disable();
    _controller.setVolume(0.0);
    _controller.removeListener(videoCallback);
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
    Future.delayed(Duration(milliseconds: 150)).then((v) {
      Navigator.of(context).pop();
    });
  }

  void videoCallback() {
    setState(() {
      _currentPositionString = formatDuration(_controller.value.position);
      _remainingString = formatDuration(
          _controller.value.duration - _controller.value.position);

      int? _totalDuration = _controller.value.duration.inMilliseconds;
      _playedValue = _controller.value.position.inMilliseconds / _totalDuration;
    });

    if (_controller.value.position >= _controller.value.duration) {
      _controller.seekTo(Duration(seconds: 0));
      Future.delayed(Duration(milliseconds: 400)).then((v) {
        Navigator.of(context).pop();
      });
    }
  }

  String formatDuration(Duration position) {
    final ms = position.inMilliseconds;
    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10 ? '$hours' : hours == 0 ? '00' : '0$hours';
    final minutesString =
        minutes >= 10 ? '$minutes' : minutes == 0 ? '00' : '0$minutes';
    final secondsString =
        seconds >= 10 ? '$seconds' : seconds == 0 ? '00' : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : hoursString + ':'}$minutesString:$secondsString';
    return formattedTime;
  }
}

class ProgressBarPainter extends CustomPainter {
  late final double progressWidth;
  late final double handleRadius;
  late final double playedValue;
  late final double bufferedValue;
  late final bool touchDown;
  late final ThemeData themeData;

  ProgressBarPainter({
    required this.progressWidth,
    required this.handleRadius,
    required this.playedValue,
    required this.bufferedValue,
    required this.touchDown,
    required this.themeData,
  });

  @override
  bool shouldRepaint(ProgressBarPainter old) {
    return playedValue != old.playedValue ||
        bufferedValue != old.bufferedValue ||
        touchDown != old.touchDown;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.square
      ..strokeWidth = progressWidth;

    final centerY = size.height / 2.0;
    final barLength = size.width - handleRadius * 2.0;

    final Offset startPoint = Offset(handleRadius, centerY);
    final Offset endPoint = Offset(size.width - handleRadius, centerY);
    final Offset progressPoint =
        Offset(barLength * playedValue + handleRadius, centerY);
    final Offset secondProgressPoint =
        Offset(barLength * bufferedValue + handleRadius, centerY);

    paint.color = HexColor("#BB8F3D").withOpacity(0.38);
    canvas.drawLine(startPoint, endPoint, paint);

    paint.color = Colors.white70;
    canvas.drawLine(startPoint, secondProgressPoint, paint);

    paint.color = HexColor("#BB8F3D");
    canvas.drawLine(startPoint, progressPoint, paint);

    final Paint handlePaint = Paint()..isAntiAlias = true;

    handlePaint.color = Colors.transparent;
    canvas.drawCircle(progressPoint, centerY, handlePaint);

    final Color _handleColor = HexColor("#BB8F3D");

    if (touchDown) {
      handlePaint.color = _handleColor.withOpacity(0.4);
      canvas.drawCircle(progressPoint, handleRadius * 2, handlePaint);
    }

    handlePaint.color = _handleColor;
    canvas.drawCircle(progressPoint, handleRadius, handlePaint);
  }
}
