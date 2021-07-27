import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/Model/EventForMobileResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/student/EventDetailsScreen.dart';


class CalendarEventScreen extends StatefulWidget {
  @override
  _CalendarEventScreenState createState() => new _CalendarEventScreenState();
}

class _CalendarEventScreenState extends State<CalendarEventScreen> {
  AuthViewModel _authViewModel = AuthViewModel();
  List<EventForMobileResponse> eventist = [];
  List<EventForMobileResponse> upcommingEventList = [];
  DateTime selectedDate = DateTime.now();
  DateTime _currentDate = DateTime(2021, 7, 21);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2021, 7, 21));
  DateTime _targetDateTime = DateTime(2021, 7, 21);
  String? languageCode;

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(schoolId == null){
      schoolId = 0;
    }
    _getEventDetail(schoolId);
  }

  static Widget _presentIcon(String day) => CircleAvatar(
        backgroundColor: HexColor("#6462AA"),
        child: Container(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;

  //var len = min(absentDates.length, presentDates.length);
  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      isScrollable: false,
      onDayPressed: (date, events) {
        this.setState(() => selectedDate = date);
        events.forEach((event) => event.title != null
            ? Utils.navigateToScreen(context, EventDetailsScreen(event, upcommingEventList))
            : Container());
      },
      height: Platform.isIOS?cHeight * 0.40:cHeight *0.50,
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      weekDayFormat: WeekdayFormat.narrow,
      weekdayTextStyle: TextStyle(
          color: HexColor("#6462AA")
      ),
      weekendTextStyle: TextStyle(
        color: Colors.black87,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Color.fromRGBO(243, 243, 243, 2),
      todayTextStyle: TextStyle(color: Colors.black),
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      targetDateTime: _targetDateTime,
      showHeader: false,
      markedDateMoreShowTotal: null,
      // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
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
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('events'.tr(),
                            style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Colors.white)),
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
              top: MediaQuery.of(context).size.height * 0.14,
              left: MediaQuery.of(context).size.height * 0.03,
              right: MediaQuery.of(context).size.height * 0.03,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                color: HexColor("FAFAFA"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height:Platform.isIOS?cHeight * 0.40:cHeight *0.50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: Wrap(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                margin: EdgeInsets.only(),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.arrow_back_ios,
                                            color: HexColor("#6462AA"), size: 16),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _targetDateTime = DateTime(
                                              _targetDateTime.year,
                                              _targetDateTime.month - 1);
                                          _currentMonth = DateFormat.yMMM()
                                              .format(_targetDateTime);
                                        });

                                        if(eventist.isNotEmpty && eventist.length > 0){
                                          List<EventForMobileResponse> tempList = [];
                                          for (int i = 0; i < eventist.length; i++) {
                                            bool isSuccess = _isUpcommingEvent(eventist[i].fromDateTime);
                                            if (isSuccess) {
                                              tempList.add(eventist[i]);
                                            }
                                          }
                                          setState(() {
                                            upcommingEventList = [];
                                            upcommingEventList.addAll(tempList);
                                          });
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        _currentMonth,
                                        style: AppTheme.regularTextStyle()
                                            .copyWith(color: HexColor("#6462AA")),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: HexColor("#6462AA"), size: 16),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _targetDateTime = DateTime(
                                              _targetDateTime.year,
                                              _targetDateTime.month + 1);
                                          _currentMonth = DateFormat.yMMM()
                                              .format(_targetDateTime);
                                        });

                                        if(eventist.isNotEmpty && eventist.length > 0){
                                          List<EventForMobileResponse> tempList = [];
                                          for (int i = 0; i < eventist.length; i++) {
                                            bool isSuccess = _isUpcommingEvent(eventist[i].fromDateTime);
                                            if (isSuccess) {
                                              tempList.add(eventist[i]);
                                            }
                                          }
                                          setState(() {
                                            upcommingEventList = [];
                                            upcommingEventList.addAll(tempList);
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.black12,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: _calendarCarouselNoHeader,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    upcommingEventList.length > 0 ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#6462AA")),
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'upcoming_events'.tr(),
                            style: AppTheme.regularTextStyle().copyWith(
                                fontSize: 16,
                                color: Color.fromRGBO(11, 11, 11, 1)),
                          ),
                        ],
                      ),
                    ) : Container(),
                    Container(
                      height: cHeight *0.28,
                      child: Scrollbar(
                        thickness: 5,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: ListView.builder(
                              itemCount: upcommingEventList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 10),
                              itemBuilder: (BuildContext context, int position) {
                                return _listRowItem(context, position);
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }

  void _getEventDetail(int schoolId) {
    Utils.showLoader(true, context);
    _authViewModel.getAllEventForMobile(schoolId.toString(), (isSuccess, message) {
     Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          eventist = _authViewModel.eventForMobileList;
          for (int i = 0; i < eventist.length; i++) {
            selectedDate = DateTime.parse(eventist[i].fromDateTime);

            bool isSuccess = _isUpcommingEvent(eventist[i].fromDateTime);
            if (isSuccess) {
              upcommingEventList.add(eventist[i]);
            }
            DateTime utcFromDate = DateTime.parse(eventist[i].fromDateTime.split('T')[0]).toUtc();
            //DateTime utcFromDate = DateTime.parse(eventist[i].fromDateTime).toUtc();
            final convertLocal = utcFromDate.toLocal();
            String date = DateFormat("yyyy,MM,dd").format(convertLocal);
            var dateInFormatText = date.split(",");
            setState(() {
              var currentDate = DateTime.now();
              var eventDate = DateTime.parse(eventist[i].fromDateTime);
              if(currentDate.isBefore(eventDate)){
                /*DateTime utcFromDate = DateTime.parse(eventist[i].fromDateTime).toUtc();
                var localFromDate = utcFromDate.toLocal();
                String strUtcFromDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(localFromDate);
                var fromDate = Utils.convertDate(strUtcFromDate, DateFormat("MM/dd/yyyy"))+" "+eventist[i].startTime;

                DateTime utcToDate = DateTime.parse(eventist[i].toDateTime).toUtc();
                var localToDate = utcToDate.toLocal();
                String strUtcToDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(localToDate);
                var toDate = Utils.convertDate(strUtcToDate, DateFormat("MM/dd/yyyy"))+" "+eventist[i].endTime;

                var eventDetails = eventist[i].eventName+"=>"+fromDate+"=>"+toDate;*/

                String resFromDate = eventist[i].fromDateTime.split('T')[0];
                DateTime utcFromDate = DateTime.parse(resFromDate).toUtc();
                var localFromDate = utcFromDate.toLocal();
                String strUtcFromDate = DateFormat("MM/dd/yyyy").format(localFromDate);
                String fromDate = strUtcFromDate+" "+eventist[i].startTime;

                String resToDate = eventist[i].toDateTime.split('T')[0];
                DateTime utcToDate = DateTime.parse(resToDate).toUtc();
                var localToDate = utcToDate.toLocal();
                String strUtcToDate = DateFormat("MM/dd/yyyy").format(localToDate);
                String toDate = strUtcToDate+" "+eventist[i].endTime;

                var eventDetails = eventist[i].eventName+"=>"+fromDate+"=>"+toDate;

                _markedDateMap.add(
                  DateTime(
                      int.parse(dateInFormatText[0]),
                      int.parse(dateInFormatText[1]),
                      int.parse(dateInFormatText[2])),
                  new Event(
                      date: new DateTime(
                          int.parse(dateInFormatText[0]),
                          int.parse(dateInFormatText[1]),
                          int.parse(dateInFormatText[2])),
                      title: eventDetails,
                      icon: _presentIcon(
                        dateInFormatText[2],
                      ),
                      dot: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('total_day'.tr()+ ': '+getDayCount(localFromDate, localToDate), style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
                            SizedBox(height: 10),
                            Text('event_details'.tr()+ ':', style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
                            Html(
                              data: eventist[i].eventDetail,
                              style: {
                                "body" : Style(
                                  fontFamily: MyFont.SSPro_regular,
                                  fontSize: FontSize.medium,
                                  color: Colors.black54
                                )
                              },
                            ),
                          ],
                        ),
                      )),
                );
              }
            });
          }
        });
        if(languageCode!.compareTo("en") != 0){
          if(languageCode!.compareTo("sr") == 0){
            languageCode = "so";
          }
          _translateEventTitleData();
        }
      } else {
        Utils.showToast(context, message, Colors.red);
      }
    });
  }

  _isUpcommingEvent(String fromDateTime) {
    String calMonth = _currentMonth.substring(0, 3);
    var newDt = Utils.convertDate(fromDateTime, DateFormat("yyyy-MMM-dd"));
    String currentMonth=newDt.split("-")[1];

    var currentDate = DateTime.now();
    var eventDate = DateTime.parse(fromDateTime);
    if (currentMonth.compareTo(calMonth)==0) {
      if(currentDate.isBefore(eventDate)){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void bottomMenu(String event, Widget? abcd) {
    List<String> eventList = event.split("=>");
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
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40, 10, 0),
                    child: Text(eventList[0],
                        style: AppTheme.customTextStyle(MyFont.SSPro_semibold,
                            18.0, Color.fromRGBO(0, 0, 0, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'start_date_time'.tr() +": "+ eventList[1],
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'end_date_time'.tr() +": "+ eventList[2],
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 16, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  abcd!,
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Divider(
                        thickness: 1, color: Color.fromRGBO(223, 223, 223, 4)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8, top: 10, bottom: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(204, 204, 204, 1)),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextButton(
                          child: Text(LabelStr.lblClose,
                              style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                                  16.0, Color.fromRGBO(255, 255, 255, 1))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _listRowItem(BuildContext context, int position) {

    String localFromDate = upcommingEventList[position].fromDateTime.split('T')[0];
    //String localFromDate = upcommingEventList[position].fromDateTime;
    DateTime utcFromDate = DateTime.parse(localFromDate).toUtc();
    var fromDate = utcFromDate.toLocal();
    String displayDate = DateFormat("MM/dd/yyyy").format(fromDate);

    return InkWell(
      onTap: () {

        String resFromDate = upcommingEventList[position].fromDateTime.split('T')[0];
        DateTime utcFromDate = DateTime.parse(resFromDate).toUtc();
        var localFromDate = utcFromDate.toLocal();
        String strUtcFromDate = DateFormat("MM/dd/yyyy").format(localFromDate);
        String fromDate = strUtcFromDate+" "+upcommingEventList[position].startTime;

        String resToDate = upcommingEventList[position].toDateTime.split('T')[0];
        DateTime utcToDate = DateTime.parse(resToDate).toUtc();
        var localToDate = utcToDate.toLocal();
        String strUtcToDate = DateFormat("MM/dd/yyyy").format(localToDate);
        String toDate = strUtcToDate+" "+upcommingEventList[position].endTime;

        var eventDetails = upcommingEventList[position].eventName+"=>"+fromDate+"=>"+toDate;
        String eventDesc = upcommingEventList[position].eventDetail;

        var details = Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('total_day'.tr()+ ': '+getDayCount(localFromDate, localToDate), style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
              SizedBox(height: 10),
              Text('event_details'.tr()+ ':', style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
              Html(
                data: eventDesc,
                style: {
                  "body" : Style(
                    fontFamily: MyFont.SSPro_regular,
                    fontSize: FontSize.medium,
                    color: Colors.black54
                  )
                },
              ),
            ],
          ),
        );

        /*DateTime utcFromDate = DateTime.parse(upcommingEventList[position].fromDateTime).toUtc();
        var localFromDate = utcFromDate.toLocal();
        String strUtcFromDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(localFromDate);
        var fromDate = Utils.convertDate(strUtcFromDate, DateFormat("MM/dd/yyyy"))+" "+upcommingEventList[position].startTime;

        DateTime utcToDate = DateTime.parse(upcommingEventList[position].toDateTime).toUtc();
        var localToDate = utcToDate.toLocal();
        String strUtcToDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(localToDate);
        var toDate = Utils.convertDate(strUtcToDate, DateFormat("MM/dd/yyyy"))+" "+upcommingEventList[position].endTime;

        var eventDetails = upcommingEventList[position].eventName+"=>"+fromDate+"=>"+toDate;*/

        if(languageCode!.compareTo("en") != 0){
          if(languageCode!.compareTo("sr") == 0){
            languageCode = "so";
          }
          _translateEventDetails(eventDesc);
        }
        bottomMenu(eventDetails, details);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(upcommingEventList[position].eventName,
                style: AppTheme.regularTextStyle()),
            Text(
                displayDate,
                style: AppTheme.customTextStyle(
                    MyFont.SSPro_regular, 14.0, Colors.black54)),
            Container(
              height: 1,
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              color: Colors.black26,
            )
          ],
        ),
      ),
    );
  }

  getDayCount(DateTime startDate, DateTime endDate){
    var from = DateTime(startDate.year, startDate.month, startDate.day);
    var to = DateTime(endDate.year, endDate.month, endDate.day);
    var count = (to.difference(from).inHours / 24).round()+1;
    if(count.toString().length == 1){
      return "0"+count.toString();
    }
    return count.toString();
  }

  _translateEventTitleData(){
    Utils.showLoader(true, context);
    List<String> titleList = [];
    for(var event in upcommingEventList){
      titleList.add(event.eventName);
    }
    String resultArr = titleList.join("===");
    WebService.translateApiCall(languageCode!, resultArr, (isSuccess, response) {
      if(isSuccess) {
        var resultTitleArr = response.toString().split("===");
        List<EventForMobileResponse> tempList = [];
        for (int i = 0; i < resultTitleArr.length; i++) {
          tempList.add(EventForMobileResponse(
            tusdEventId: upcommingEventList[i].tusdEventId,
            schoolId: upcommingEventList[i].schoolId,
            eventTypeId: upcommingEventList[i].eventTypeId,
            eventName: resultTitleArr[i],
            fromDateTime: upcommingEventList[i].fromDateTime,
            toDateTime: upcommingEventList[i].toDateTime,
            eventDetail: upcommingEventList[i].eventDetail,
            freeFields1: upcommingEventList[i].freeFields1,
            freeFields2: upcommingEventList[i].freeFields2,
            freeFields3: upcommingEventList[i].freeFields3,
            freeFields4: upcommingEventList[i].freeFields4,
            isActive: upcommingEventList[i].isActive,
            shareMode: upcommingEventList[i].shareMode,
            createdBy: upcommingEventList[i].createdBy,
            createdOn: upcommingEventList[i].createdOn,
            updatedBy: upcommingEventList[i].updatedBy,
            updatedOn: upcommingEventList[i].updatedOn,
            eventTypeName: upcommingEventList[i].eventTypeName,
            schoolName: upcommingEventList[i].schoolName,
            startTime: upcommingEventList[i].startTime,
            endTime: upcommingEventList[i].endTime,
            schoolIds: upcommingEventList[i].schoolIds
          ));
        }
        if (upcommingEventList.length == tempList.length) {
          setState(() {
            upcommingEventList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
    });
    Utils.showLoader(false, context);
  }

  _translateEventDetails(String eventDesc){
    WebService.translateApiCall(languageCode!, eventDesc, (isSuccess, response) {
      if(isSuccess){
        setState(() {
          eventDesc = response.toString();
        });
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
    });
  }
}
