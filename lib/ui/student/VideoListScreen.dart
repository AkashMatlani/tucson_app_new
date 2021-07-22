import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/VideoPlayerScreen.dart';
import 'package:tucson_app/ui/student/videoPlayerStuff/SamplePlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoListScreen extends StatefulWidget {
  VideoListScreen(this.title, this.fromScreen);

  String title;
  String fromScreen;

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  bool isLoading = true;
  String? languageCode;
  List<ContentTransactionResponse> _videoList = [];
  late String imagePath = "";
  List<String> _imageLink = [];

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if (schoolId == null) {
      schoolId = 0;
    }
    _getContentList(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  height: MediaQuery.of(context).size.height * 0.06,
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
                        child: Text(widget.title,
                            style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Colors.white)),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: HexColor("FAFAFA")),
                  height: MediaQuery.of(context).size.height * 0.88,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.height * 0.012,
            right: MediaQuery.of(context).size.height * 0.012,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.88,
              child: _videoList.length == 0
                  ? emptyListView()
                  : SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: _videoList.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          itemBuilder: (BuildContext context, int position) {
                            return _listRowItems(context, position);
                          }),
                    ),
            ),
          )
        ],
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if (_videoList[index].objectPath.contains("https://www.youtube.com/")) {
          /* Utils.navigateToScreen(
              context, DisplayWebview(_videoList[index].objectPath));*/
          _launchYoutubeVideo(_videoList[index].objectPath);
        } else if (
            _videoList[index].objectPath.contains("mp4") ||
            _videoList[index].objectPath.contains("mov") ||
            _videoList[index].objectPath.contains("m4a") ||
            _videoList[index].objectPath.contains("3gp") ||
            _videoList[index].objectPath.contains("aac") ||
            _videoList[index].objectPath.contains("mkv")) {
          Utils.navigateToScreen(
              context, SamplePlayer(_videoList[index].objectPath));
        } else {
          /* Utils.navigateToScreen(
              context, DisplayWebview(_videoList[index].objectPath));*/
          _launchURL(_videoList[index].objectPath);
        }
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _videoList[index].objectPath.contains("https://www.youtube.com/")
            ?   Container(
                margin: EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  MyImage.youTubeThubmail,
                  fit: BoxFit.fitWidth,
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: 400,
                )):
            //?Image.network('https://img.youtube.com/vi/6cwnBBAVIwE/0.jpg'):
            Container(
                margin: EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                //child: new Image.file(File(imagePath)),
                // child: Image.asset(MyImage.videoUrlImage),
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        final data = snapshot.data as String;
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: 400,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    image: FileImage(File(data)),
                                    fit: BoxFit.fill)));
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: getThumbNail(_videoList[index].objectPath),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 20),
                child: Text(_videoList[index].objectName,
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_bold, 20.0, Color.fromRGBO(0, 0, 0, 1))))
          ]),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: isLoading
          ? Container()
          : Text('no'.tr() + " " + widget.title + " " + 'found'.tr(),
              style: AppTheme.regularTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  late String tempdat;

  _getContentList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "Video"
    };

    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, widget.fromScreen,
        (isSuccess, message) {
      if (isSuccess) {
        setState(() {
          _videoList = [];
          for (var data in _contentViewModel.contentList) {
            for (var innerData in data.contentTransactionTypeJoin) {
              if (innerData.contentTransTypeName.compareTo("Video") == 0) {
                _videoList.add(innerData);
                _imageLink.add(innerData.objectPath);

                tempdat = innerData.objectPath;
                // getVideoThumbinail(innerData.objectPath);
              }
            }
          }
        });

        if (languageCode!.compareTo("en") != 0) {
          translateListData();
        } else {
          Utils.showLoader(false, context);
          isLoading = false;
        }
      } else {
        Utils.showLoader(false, context);
        isLoading = false;
        setState(() {
          _videoList = [];
        });
      }
    });
  }

  translateListData() {
    List<String> nameList = [];
    List<ContentTransactionResponse> tempList = [];
    for (var items in _videoList) {
      nameList.add(items.objectName);
    }
    String nameStr = nameList.join("==)");
    WebService.translateApiCall(languageCode!, nameStr, (isSuccess, response) {
      if (isSuccess) {
        List<String> resultArr = response.toString().split("==)");
        for (int i = 0; i < resultArr.length; i++) {
          tempList.add(ContentTransactionResponse(
              contentTransactionId: _videoList[i].contentTransactionId,
              contentMasterId: _videoList[i].contentMasterId,
              contentTransTypeId: _videoList[i].contentTransTypeId,
              objectName: resultArr[i],
              objectPath: _videoList[i].objectPath,
              contentTransTypeName: _videoList[i].contentTransTypeName));
        }
        if (_videoList.length == tempList.length) {
          setState(() {
            _videoList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      isLoading = false;
      Utils.showLoader(false, context);
    });
  }

  late var fileName;

  Future<void> _launchYoutubeVideo(String _youtubeUrl) async {
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

  void _launchURL(String path) async => await canLaunch(path)
      ? await launch(path)
      : throw 'Could not launch $path';

  Future getThumbNail(String image) async {
    var fileName = await VideoThumbnail.thumbnailFile(
      video: image,
      thumbnailPath: (await getApplicationDocumentsDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 100,
      maxWidth: 200,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 50,
    );

    return fileName;
  }


  String? getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
}
