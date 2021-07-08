import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/HealthSupportResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/VideoPlayer.dart';
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
  late int schoolId;
  late Geolocator _geolocator;
  late Position _currentPosition;
  bool loadedApiCall = false;
  late var tempvalue;

  @override
  void initState() {
    super.initState();
    _getPrefsData();
  }

  _getPrefsData() async {
    schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    dob = await PrefUtils.getValueFor(PrefUtils.userDOB);
    if (schoolId == null) {
      schoolId = 0;
    }
    bool isPopUpOpenFirst =
        await PrefUtils.getValueFor(PrefUtils.mentalHealthpopUp);
    if (isPopUpOpenFirst == null || !isPopUpOpenFirst) {
      bottomPopup(context);
    } else {
      _getCurrentLocation();
    }
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
        child: Text(loadedApiCall ? LabelStr.lblNoMentalHealth : "",
            style: AppTheme.regularTextStyle()
                .copyWith(fontSize: 18, color: Colors.red)));
  }

  _mentalHealthSupportApiCall(int schoolId) {
    var params = {"schoolId": schoolId};
    WebService.postAPICall(WebService.tusdSupportBySchoolID, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        setState(() {
          isLoading = false;
          loadedApiCall = true;
          _supportResponse = HealthSupportResponse.fromJson(response.body);
          getSUpportNotifierMail(
              _currentPosition.latitude, _currentPosition.longitude);
          // mailSend();
          //_launchURL("akash.maltani@dashtechinc.com","test mail from flutter","Testtstststststststststst");
          //sendMail();
        });
      }
    }).catchError((onError) {
      Utils.showLoader(false, context);
      isLoading = false;
      loadedApiCall = true;
      Utils.showToast(context, LabelStr.connectionError, Colors.red);
    });
  }

  /* Future<void> mailSend()
  async {
    final Email email = Email(
      body: 'Test Mail From Flutter Android',
      subject: 'Test Mail',
      recipients: ['akash.maltani@dashtechinc.com'],
      cc: ['akash.maltani@dashtechinc.com'],
      bcc: ['akash.maltani@dashtechinc.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

/*  Future<void> sendMail()
  async {
    String username = 'akash.matlani.dashtech@gmail.com';
    String password = 'Akash@@623';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    //final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Akash Matlani')
      ..recipients.add('akash.maltani@dashtechinc.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }*/

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
                    child: Text(LabelStr.lblMentalHealthSupport,
                        style: AppTheme.customTextStyle(MyFont.SSPro_bold, 20.0,
                            Color.fromRGBO(0, 0, 0, 1))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: LabelStr.lblHippa,
                      style: AppTheme.regularTextStyle().copyWith(
                          fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    TextSpan(
                        text: LabelStr.lblHippLink,
                        style: AppTheme.regularTextStyle()
                            .copyWith(fontSize: 16, color: Colors.blueAccent),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Utils.navigateToScreen(
                                context, DisplayWebview(LabelStr.lblHippLink));
                          }),
                  ])),
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
                            onPressed: () async {
                              /*Timer(Duration(milliseconds: 200), (){
                                _makingPhoneCall(_supportResponse.nsphPhoneNumber);
                              });*/
                              PrefUtils.setBoolValue(
                                  PrefUtils.mentalHealthpopUp, true);
                              Navigator.of(context).pop();
                              int age = Utils.calculateAge(DateTime.parse(dob));

                              if (age >= 13) {
                                var statusResponse =
                                    await Permission.location.status;
                                if (statusResponse.isGranted) {
                                  _getCurrentLocation();
                                } else {
                                  Map<Permission, PermissionStatus> status =
                                      await [
                                    Permission.location,
                                  ].request();
                                  print("Permission status :: $status");
                                  getValuesFromMap(status);
                                  if (tempvalue == PermissionStatus.granted) {
                                    _getCurrentLocation();
                                  } else if (tempvalue ==
                                      PermissionStatus.denied) {
                                    print(
                                        'Denied. Show a dialog with a reason and again ask for the permission.');
                                    Map<Permission, PermissionStatus> status =
                                        await [
                                      Permission.location,
                                    ].request();

                                    // ignore: unrelated_type_equality_checks
                                  } else if (tempvalue ==
                                      PermissionStatus.permanentlyDenied) {
                                    print(
                                        'Take the user to the settings page.');
                                    Map<Permission, PermissionStatus> status =
                                        await [
                                      Permission.location,
                                    ].request();
                                  }
                                }
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
                            PrefUtils.setBoolValue(
                                PrefUtils.mentalHealthpopUp, false);
                            Timer(
                                Duration(milliseconds: 100),
                                () => Utils.backWithNoTransition(
                                    context, StudentDashboardScreen()));
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

  _getCurrentLocation() {
    isLoading = true;
    Utils.showLoader(true, context);
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      if (_currentPosition != null) {
        print(
            "${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
        /* List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
          print(placemarks.)*/
        Timer(Duration(milliseconds: 200), () {
          _mentalHealthSupportApiCall(schoolId);
        });
      } else {
        isLoading = false;
        Utils.showLoader(false, context);
        Utils.showToast(context, "Location Not Found", Colors.red);
      }
    }).catchError((e) {
      isLoading = false;
      Utils.showLoader(false, context);
      print(e);
    });
  }

  void getValuesFromMap(Map map) {
    // Get all values
    print('----------');
    print('Get values:');
    map.values.forEach((value) {
      tempvalue = value;
      print(value);
    });
  }

  void getSUpportNotifierMail(var latitude, var longitude) {
    Utils.showLoader(true, context);
    var params = {
      "schoolId": schoolId,
      "latitiude": latitude.toString(),
      "longtitude": longitude.toString()
    };
    var headers = {"Content-Type": 'application/json'};
    var url = WebService.baseUrl + WebService.supportNotifierMail;
    var postUri = Uri.parse(url);
    http
        .post(postUri, body: jsonEncode(params), headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        var result = response.body;
        var jsValue = json.decode(result);
        var message = jsValue["messages"][0]["messageText"];
        Utils.showToast(context, message, Colors.green);
        Utils.showLoader(false, context);
      } else {
        var jsValue = json.decode(response.body);
        var message = jsValue[0]["errorMessage"];
        Utils.showToast(context, message, Colors.red);
      }
    }).catchError((error) {
      Utils.showToast(context, LabelStr.connectionError, Colors.red);
    });
  }
}
