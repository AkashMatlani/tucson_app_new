import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/HealthSupportResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/VideoPlayerScreen.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MentalHealthSupportScreen extends StatefulWidget {
  @override
  _MentalHealthSupportScreenState createState() =>
      _MentalHealthSupportScreenState();
}

class _MentalHealthSupportScreenState extends State<MentalHealthSupportScreen> {
  late HealthSupportResponse _supportResponse;
  bool isLoading = true;
  late double blockSizeVertical;
  late String dob;
  late Geolocator _geolocator;
  late Position _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((_) {
      bottomPopup(context);
    });
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    dob = await PrefUtils.getValueFor(PrefUtils.UserDob);
    if (schoolId == null) {
      schoolId = 0;
    }
    _mentalHealthSupportApiCall(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    blockSizeVertical = screenHeight / 100;

    return WillPopScope(
      onWillPop: () =>
          Utils.backWithNoTransition(context, StudentDashboardScreen()),
      child: Scaffold(
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
                          child: Text(LabelStr.lblMentalHealthSupport,
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
                height: MediaQuery.of(context).size.height * 0.88,
                margin: EdgeInsets.all(10),
                child: isLoading
                    ? emptyListView()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_supportResponse.supportDocument == null) {
                                  Utils.showToast(
                                      context, LabelStr.lblNoVideo, Colors.red);
                                } else if (_supportResponse.supportDocument
                                    .contains("https://www.youtube.com/")) {
                                  Utils.navigateToScreen(
                                      context,
                                      DisplayWebview(
                                          _supportResponse.supportDocument));
                                } else {
                                  Utils.navigateToScreen(
                                      context,
                                      VideoPlayerScreen(
                                          _supportResponse.supportDocument));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child:
                                    /*ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              useOldImageOnUrlChange: false,
                              imageUrl: getVideoThumbinail(),
                              placeholder: (context, url) => Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset(MyImage.videoUrlImage),
                            ),
                          )*/
                                    Image.asset(MyImage.videoUrlImage,
                                        fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Utils.navigateToScreen(
                                          context,
                                          DisplayWebview(_supportResponse
                                              .healthButtonAction));
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Color.fromRGBO(245, 246, 252, 1),
                                        elevation: 5,
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12.0, 12.0, 12.0, 8.0),
                                                child: SvgPicture.asset(
                                                    MyImage.healthSupportIcon)),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  12.0, 12.0, 12.0, 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    LabelStr
                                                        .lblBehaviorialHealth,
                                                    style: AppTheme
                                                            .regularTextStyle()
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Utils.navigateToScreen(
                                          context,
                                          DisplayWebview(_supportResponse
                                              .talkSpaceButtonAction));
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Color.fromRGBO(245, 246, 252, 1),
                                        elevation: 5,
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    12.0, 12.0, 12.0, 8.0),
                                                child: SvgPicture.asset(
                                                    MyImage.userChatIcon)),
                                            SizedBox(height: 5),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  12.0, 12.0, 12.0, 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    LabelStr.lblTalkSpace,
                                                    style: AppTheme
                                                            .regularTextStyle()
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 3)
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: SvgPicture.asset(MyImage.callIcon),
                                    ),
                                    SizedBox(width: 10),
                                    Text(LabelStr.lblSuicideLifeline,
                                        style: AppTheme.customTextStyle(
                                            MyFont.SSPro_regular,
                                            16.0,
                                            Colors.white))
                                  ],
                                ),
                                onPressed: () {
                                  _makingPhoneCall(
                                      _supportResponse.nsphPhoneNumber);
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("1-800-273-8255",
                                style: AppTheme.regularTextStyle()
                                    .copyWith(fontSize: 30)),
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: SvgPicture.asset(
                                        MyImage.messageIcon,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(LabelStr.lblSuicideLifeline,
                                        style: AppTheme.customTextStyle(
                                            MyFont.SSPro_regular,
                                            16.0,
                                            Colors.white))
                                  ],
                                ),
                                onPressed: () {
                                  Utils.navigateToScreen(
                                      context,
                                      DisplayWebview(
                                          _supportResponse.nsphChatUrl));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getVideoThumbinail() async {
    String? fileName;
    try {
      fileName = await VideoThumbnail.thumbnailFile(
        video: _supportResponse.supportDocument,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 240,
        quality: 50,
      );
    } catch (e) {
      print(e);
      fileName = "";
    }
    return fileName;
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: isLoading
          ? Container()
          : Text(LabelStr.lblNoMentalHealth,
              style: AppTheme.regularTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _mentalHealthSupportApiCall(int schoolId) {
    Utils.showLoader(true, context);
    var params = {"schoolId": schoolId};
    WebService.postAPICall(WebService.tusdSupportBySchoolID, params)
        .then((response) {
      Utils.showLoader(false, context);
      isLoading = false;
      if (response.statusCode == 1) {
        setState(() {
          _supportResponse = HealthSupportResponse.fromJson(response.body);
        });
      }
    }).catchError((onError) {
      Utils.showLoader(false, context);
      isLoading = false;
      Utils.showToast(context, LabelStr.connectionError, Colors.red);
    });
  }

  void bottomPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
        ),
        child: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40, 10, 10),
                child: Text(LabelStr.lblHippaStatement,
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
              ),*/
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                    child: Text("PRIVACY NOTICE",
                        style: AppTheme.customTextStyle(MyFont.SSPro_bold, 20.0,
                            Color.fromRGBO(0, 0, 0, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                  child: Text(
                    LabelStr.lblHippa,
                    style: AppTheme.regularTextStyle().copyWith(
                        fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Divider(
                      thickness: 1, color: Color.fromRGBO(223, 223, 223, 4)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2, 2, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
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
                          height: blockSizeVertical * 7,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            child: Text(LabelStr.lblAgree,
                                style: AppTheme.customTextStyle(
                                    MyFont.SSPro_bold,
                                    16.0,
                                    Color.fromRGBO(255, 255, 255, 1))),
                            onPressed: () {
                              Navigator.of(context).pop();
                              /*Timer(Duration(milliseconds: 200), (){
                                _makingPhoneCall(_supportResponse.nsphPhoneNumber);
                              });*/

                              if (isAdult2(dob)) {
                                /* _geolocator = Geolocator();
                                LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

                                checkPermission();

                                StreamSubscription positionStream = _geolocator.getPositionStream(locationOptions).listen(
                                        (Position position) {
                                      _position = position;
                                    });*/
                                _getSchoolId();
                              } else {
                                Utils.showToast(
                                    context,
                                    "Mental Health Support is available only for Students with age >=13 years",
                                    Colors.red);
                                Timer(
                                    Duration(milliseconds: 100),
                                    () => Utils.backWithNoTransition(
                                        context, StudentDashboardScreen()));
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(204, 204, 204, 1)),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextButton(
                          child: Text(LabelStr.lblCancel,
                              style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                                  16.0, Color.fromRGBO(255, 255, 255, 1))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _makingPhoneCall(String number) async {
    String url = 'tel:' + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isAdult2(String birthDateString) {
    String datePattern = "YYYY-MM-DD HH:MI:SS";
    // Current time - at this moment
    DateTime today = DateTime.now();
    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    // Date to check but moved 13 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 13,
      birthDate.month,
      birthDate.day,
    );
    return adultDate.isBefore(today);
  }
/* void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }*/
}
