import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/AudioPlayerScreen.dart';
import 'package:tucson_app/ui/ImageViewerScreen.dart';
import 'package:tucson_app/ui/VideoPlayerScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DocumentViewerScreen.dart';

class BlogDetailsScreen extends StatefulWidget {
  BlogDetailsScreen(this.title, this.contentResponse);

  ContentResponse contentResponse;
  String title;

  @override
  _BlogDetailsScreenState createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  late double blockSizeVertical;
  late double blockSizeHorizontal;
  var screenWeight;
  var screenHeight;
  String doclink = "";
  String imageLink = "";
  String videoLink = "";
  String audioLink = "";
  String webLink = "";
  String? languageCode;
  String? contentTitle;
  String? contentDesc;

  List<String> imageList = [];
  List<String> docList = [];
  List<String> videoList = [];
  List<String> audioList = [];
  List<String> webList = [];

  String svgPicture = "";

  @override
  void initState() {
    super.initState();
    if (widget.title.compareTo('blog_details'.tr()) == 0) {
      svgPicture = MyImage.blogThubmail;
    } else if (widget.title.compareTo('story_details'.tr()) == 0) {
      svgPicture = MyImage.storiesThubmail;
    } else if (widget.title.compareTo('article_details'.tr()) == 0) {
      svgPicture = MyImage.articleThubmail;
    } else if (widget.title.compareTo('activity_details'.tr()) == 0) {
      svgPicture = MyImage.articleThubmail;
    }

    for (var data in widget.contentResponse.contentTransactionTypeJoin) {
      if (data.contentTransTypeName.compareTo("Image") == 0) {
        // imageLink = data.objectPath;
        imageList.add(data.objectPath);
      } else if (data.contentTransTypeName.compareTo("Files") == 0) {
        // doclink = data.objectPath;
        docList.add(data.objectPath);
      } else if (data.contentTransTypeName.compareTo("Video") == 0) {
        //  videoLink = data.objectPath;
        videoList.add(data.objectPath);
      } else if (data.contentTransTypeName.compareTo("Audio") == 0) {
        // audioLink = data.objectPath;
        audioList.add(data.objectPath);
      } else {
        //webLink = data.objectPath;
        webList.add(data.objectPath);
      }
    }
    setState(() {
      contentTitle = widget.contentResponse.contentTitle;
      contentDesc = "<div>"+widget.contentResponse.content+"</div>";
    });
    getPrefsData();
  }

  void getPrefsData() async {
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if (languageCode == null) {
      languageCode = "en";
    }
    if (languageCode!.compareTo("en") != 0) {
      _translateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWeight = MediaQuery.of(context).size.width;
    blockSizeVertical = screenHeight / 100;
    blockSizeHorizontal = screenWeight / 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(widget.title,
                              style: AppTheme.regularTextStyle()
                                  .copyWith(fontSize: 18, color: Colors.white)),
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
                height: MediaQuery.of(context).size.height * 0.82,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height * 0.24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: HexColor("#6462AA"), width: 0.3)),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              svgPicture,
                              fit: BoxFit.fitWidth,
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: 400,
                            )
                        ),
                        SizedBox(height: 15),
                        Text(contentTitle!,
                            style: AppTheme.customTextStyle(
                                MyFont.SSPro_semibold,
                                20.0,
                                Color.fromRGBO(0, 0, 0, 1))),
                        SizedBox(height: 5),
                        Text(
                            Utils.convertDate(widget.contentResponse.createdOn,
                                DateFormat("MMM dd, yyyy")),
                            style: AppTheme.regularTextStyle().copyWith(
                                fontSize: 14,
                                color: Color.fromRGBO(111, 111, 111, 1))),
                        SizedBox(height: 5),
                        SelectableHtml(
                          data: contentDesc,
                          style: {
                            "body": Style(
                                fontFamily: MyFont.SSPro_regular,
                                fontSize: FontSize.medium,
                                color: Colors.black54
                            )
                          },
                          onLinkTap: (String? url,
                              RenderContext ctx,
                              Map<String, String> attributes,
                              dom.Element? element) {
                            _launchURL(url!);
                          },
                          onAnchorTap: (String? url,
                              RenderContext ctx,
                              Map<String, String> attributes,
                              dom.Element? element) {
                            _launchURL(url!);
                          }
                        ),
                        SizedBox(height: 10),
                        imageList.length > 0 ? imageWidget() : Container(),
                        // doclink.length > 0 ? docWidget() : Container(),
                        videoList.length > 0 ? videoWidget() : Container(),
                        //audioList.length > 0 ? audioWidget() : Container(),
                        webList.length > 0 ? webWidget() : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  imageWidget() {
    return Container(
      child: Wrap(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text("Images" + " (" + imageList.length.toString() + ")")),
          SizedBox(
            width: screenWeight,
            height: (screenWeight - 40) / 3,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: (screenWeight - 40) / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: imageList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return _listRowItem(ctx, index);
                }),
          ),
        ],
      ),
    );
  }

  videoWidget() {
    return Container(
      child: Wrap(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Text("Videos" + " (" + videoList.length.toString() + ")")),
          SizedBox(
              width: screenWeight,
              height: (screenWeight - 40) / 3,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: (screenWeight - 40) / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext ctx, index) {
                    return _listRowItemVideo(ctx, index);
                  })),
        ],
      ),
    );
  }

  docWidget() {
    return Container(
      child: Wrap(
        children: [
          Text("Document" + " (" + docList.length.toString() + ")"),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: docList.length,
              itemBuilder: (BuildContext ctx, index) {
                return _listRowItemDoc(ctx, index);
              }),
        ],
      ),
    );
  }

  audioWidget() {
    return Container(
      child: Wrap(
        children: [
          Text("Audio" + " (" + audioList.length.toString() + ")"),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: audioList.length,
              itemBuilder: (BuildContext ctx, index) {
                return _listRowAudioDoc(ctx, index);
              }),
        ],
      ),
    );
  }

  webWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text("Link" + " (" + webList.length.toString() + ")")),
          ListView.builder(
              itemCount: webList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int position) {
                return _listWebDoc(context, position);
              }),
        ],
      ),
    );
  }

  _contentTypeAction(String type, String link) {
    return InkWell(
      onTap: () {
        if (type.compareTo("Image") == 0) {
          Utils.navigateToScreen(context, ImageViewerScreen(link));
        } else if (type.compareTo("Files") == 0) {
          Utils.navigateToScreen(context, DocumentViewerScreen(link));
        } else if (type.compareTo("Video") == 0) {
          if (link.contains("https://www.youtube.com/") == 0) {
            // Utils.navigateToScreen(context, DisplayWebview(link));
            _launchURL(link);
          } else {
            Utils.navigateToScreen(context, VideoPlayerScreen(link));
          }
        } else if (type.compareTo("Audio") == 0) {
          Utils.navigateToScreen(context, AudioPlayerScreen(link));
        } else {
          // Utils.navigateToScreen(context, DisplayWebview(link));
          _launchURL(link);
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Text(link,
            style: AppTheme.regularTextStyle().copyWith(color: Colors.blue)),
      ),
    );
  }

  void _translateData() {
    Utils.showLoader(true, context);
    String inputData = widget.contentResponse.contentTitle +
        "==)" +
        widget.contentResponse.content;
    WebService.translateApiCall(languageCode!, inputData,
        (isSuccess, response) {
      if (isSuccess) {
        setState(() {
          contentTitle = response.toString().split("==)")[0];
          contentDesc = "<div>"+response.toString().split("==)")[1]+"</div>";
        });
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      Utils.showLoader(false, context);
    });
  }

  _listRowItem(BuildContext context, int position) {
    return InkWell(
        onTap: () {
          Utils.navigateToScreen(
              context, ImageViewerScreen(imageList[position]));
        },
        child: Container(
          height: screenWeight - 40 / 3,
          width: screenWeight - 40 / 3,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new CachedNetworkImageProvider(imageList[position]),
            ),
          ),
        ));
  }

  _listRowItemVideo(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        Utils.navigateToScreen(context, VideoPlayerScreen(videoList[position]));
      },
      child: Container(
        height: screenHeight * 50,
        width: screenWeight - 40 / 3,
        child: Image.asset(MyImage.audioUrlImage, fit: BoxFit.fill),
      ),
    );
  }

  _listRowItemDoc(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        Utils.navigateToScreen(
            context, DocumentViewerScreen(docList[position]));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Image.asset(MyImage.audioUrlImage, fit: BoxFit.fill),
      ),
    );
  }

  _listRowAudioDoc(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        Utils.navigateToScreen(context, AudioPlayerScreen(audioList[position]));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Image.asset(MyImage.audioUrlImage, fit: BoxFit.fill),
      ),
    );
  }

  _listWebDoc(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        // Utils.navigateToScreen(context, DisplayWebview(webList[position]));
        _launchURL(webList[position]);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
          child: Text(
        webList[position],
        style: TextStyle(color: Colors.blueAccent),
      )),
    );
  }

  void _launchURL(String path) async => await canLaunch(path)
      ? await launch(path)
      : throw 'Could not launch $path';
}
