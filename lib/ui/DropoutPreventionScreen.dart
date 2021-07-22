import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/Model/DropOutPreventionEmailsModel.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:http/http.dart' as http;
import 'package:tucson_app/ui/parent/DropOutPostScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DropoutPreventionScreen extends StatefulWidget {
  @override
  _DropoutPreventionScreenState createState() =>
      _DropoutPreventionScreenState();
}

class _DropoutPreventionScreenState extends State<DropoutPreventionScreen> {
  bool isLoading = true;
  List<DropOutPreventionEmailsModel> _dropOutModelList = [];
  bool isHTML = false;
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  String youTubeId ="bJTpz1fL4k4";
  late PlayerState _playerState;
  final List<String> _ids = [
    'bJTpz1fL4k4',
  ];

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      _getSchoolList();
    });

    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: HexColor("#6462AA"),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.03,
                      0,
                      MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('dropout_prevention'.tr(),
                            style: AppTheme.regularTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: HexColor("FAFAFA")),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 15,
            right: 15,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                 // _launchYoutubeVideo("https://youtu.be/bJTpz1fL4k4"),
                 /* Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                  ),*/
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    topActions: <Widget>[
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          _controller.metadata.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        onPressed: () {
                         // log('Settings Tapped!');
                        },
                      ),
                    ],
                    onReady: () {
                      _isPlayerReady = true;
                    },
                    onEnded: (data) {
                      _controller
                          .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          HexColor("#6462AA"),
                          HexColor("#4CA7DA"),
                          HexColor("#20B69E"),
                        ],
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(LabelStr.lblContactSpecialist,
                                      style: AppTheme.customTextStyle(
                                          MyFont.SSPro_semibold,
                                          16.0,
                                          Colors.white)))),
                          Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(Icons.keyboard_arrow_up,
                                  color: Colors.white, size: 30))
                        ],
                      ),
                      onPressed: () {
                        print("Call me");
                      },
                    ),
                  ),
                  SizedBox(height: 15),

            ConstrainedBox(
                constraints:BoxConstraints(minHeight: 80,maxHeight: MediaQuery.of(context).size.height*0.30),
                    child:  ListView.builder(
                        itemCount: _dropOutModelList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(top: 20),
                        itemBuilder:
                            (BuildContext context, int position) {
                          return _listRowItem(context, position);
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          HexColor("#6462AA"),
                          HexColor("#4CA7DA"),
                          HexColor("#20B69E"),
                        ],
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Text('enroll'.tr(),
                          style: AppTheme.customTextStyle(
                              MyFont.SSPro_regular, 16.0, Colors.white)),
                      onPressed: () {
                        _controller.pause();
                        Utils.navigateToScreen(context, DropOutPostScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getSchoolList() {
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.getAllDropoutSpeciality)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          setState(() {
            isLoading = false;
            Utils.showLoader(false, context);
            _dropOutModelList = [];
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            for (var data in response.body) {
              _dropOutModelList
                  .add(DropOutPreventionEmailsModel.fromJson(data));
            }
          });
        } else {
          isLoading = false;
          Utils.showLoader(false, context);
        }
      } else {
        isLoading = false;
        Utils.showToast(context, response.message, Colors.red);
        print(
            "******************** ${response.message} ************************");
      }
    }).catchError((error) {
      isLoading = false;
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: isLoading
          ? Container()
          : Text('no_educational'.tr(),
              style: AppTheme.regularTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _listRowItem(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        // Utils.navigateToScreen(context, DisplayWebview(_communityEventList[position].objectPath));
        // _launchURL(_communityEventList[position].objectPath);
        send(_dropOutModelList[position].specialistEmail);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(_dropOutModelList[position].specialistName,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontFamily: MyFont.SSPro_semibold))),
                  Expanded(
                      flex: 6,
                      child: Text(_dropOutModelList[position].specialistEmail,
                          style: AppTheme.regularTextStyle()
                              .copyWith(color: Colors.blueAccent)))
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> send(String emailTo) async {
    final Email email = Email(
      body: "Hello Tucson Team",
      subject: "This is testing mail for dropout prevantion",
      recipients: [emailTo],
      isHTML: isHTML,
    );
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
     // platformResponse = 'success';
    } catch (error) {
     // platformResponse = error.toString();
    }

    if (!mounted) return;

   /* ScaffoldMessenger.of(context).showSnackBar(
     *//* SnackBar(
        content: Text(platformResponse),
      ),*//*
    );*/
  }

  _launchYoutubeVideo(String _youtubeUrl) async {
    if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
      if (await canLaunch(_youtubeUrl)) {
        final bool _nativeAppLaunchSucceeded = await launch(
          _youtubeUrl,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!_nativeAppLaunchSucceeded) {
          await launch(_youtubeUrl, forceSafariVC: true);
        }
      }
    }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }
}
