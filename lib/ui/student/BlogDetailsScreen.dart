import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/ui/AudioPlayerScreen.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/ImageViewerScreen.dart';
import 'package:tucson_app/ui/VideoPlayerScreen.dart';

import '../DocumentViewerScreen.dart';

class BlogDetailsScreen extends StatefulWidget {

  BlogDetailsScreen(this.title, this.contentResponse);
  ContentResponse contentResponse;
  String title;

  @override
  _BlogDetailsScreenState createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {

  String doclink="";
  String imageLink="";
  String videoLink="";
  String audioLink="";
  String webLink="";

  @override
  void initState() {
    super.initState();
    if(widget.title.compareTo(LabelStr.lblStudentBlogs) ==0){
      widget.title = LabelStr.lblBlogDetails;
    }
    for(var data in widget.contentResponse.contentTransactionTypeJoin){
      if(data.contentTransTypeName.compareTo("Image") == 0){
        imageLink = data.objectPath;
      } else if(data.contentTransTypeName.compareTo("Files") == 0){
        doclink = data.objectPath;
      } else if(data.contentTransTypeName.compareTo("Video") == 0){
        videoLink = data.objectPath;
      }else if(data.contentTransTypeName.compareTo("Audio") == 0){
        audioLink = data.objectPath;
      } else{
        webLink = data.objectPath;
      }
    }
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
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
                  height: MediaQuery.of(context).size.height*0.06,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
                  height: MediaQuery.of(context).size.height*0.88,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.12,
            left: MediaQuery.of(context).size.height*0.012,
            right: MediaQuery.of(context).size.height*0.012,
            child: Container(
              height: MediaQuery.of(context).size.height*0.88,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: MediaQuery.of(context).size.height*0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: Image.asset(MyImage.videoUrlImage, fit: BoxFit.fill),
                      ),
                      SizedBox(height: 20),
                      Text(Utils.convertDate(widget.contentResponse.createdOn, DateFormat("MMM dd, yyyy")), style: AppTheme.regularTextStyle().copyWith(fontSize: 14,color: Color.fromRGBO(111, 111, 111, 1))),
                      SizedBox(height: 5),
                      Text(widget.contentResponse.contentTitle, style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 20.0, Color.fromRGBO(0, 0, 0, 1))),
                      SizedBox(height: 30),
                      Html(
                        data: widget.contentResponse.content,
                        defaultTextStyle: AppTheme.regularTextStyle(),
                      ),
                      SizedBox(height: 10),
                      imageLink.isNotEmpty ? _contentTypeAction("Image", imageLink) : Container(),
                      doclink.isNotEmpty ? _contentTypeAction("Files", doclink) : Container(),
                      videoLink.isNotEmpty ? _contentTypeAction("Video", videoLink) : Container(),
                      audioLink.isNotEmpty ? _contentTypeAction("Audio", audioLink) : Container(),
                      webLink.isNotEmpty ? _contentTypeAction("Links", webLink) : Container(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _contentTypeAction(String type, String link){
    return InkWell(
      onTap: (){
        if(type.compareTo("Image") == 0){
          Utils.navigateToScreen(context, ImageViewerScreen(link));
        } else if(type.compareTo("Files") == 0){
          Utils.navigateToScreen(context, DocumentViewerScreen(link));
        } else if(type.compareTo("Video") == 0){
          if(link.contains("https://www.youtube.com/") == 0){
            Utils.navigateToScreen(context, DisplayWebview(link));
          } else {
            Utils.navigateToScreen(context, VideoPlayerScreen(link));
          }
        } else if(type.compareTo("Audio") == 0){
          Utils.navigateToScreen(context, AudioPlayerScreen(link));
        } else {
          Utils.navigateToScreen(context, DisplayWebview(link));
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Text(link, style: AppTheme.regularTextStyle().copyWith(color: Colors.blue)),
      ),
    );
  }
}
