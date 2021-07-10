import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
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
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class CalendarEvent extends StatefulWidget {
  @override
  _CalendarEventState createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  late DateTime _targetDateTime;
  late double cHeight;
  AuthViewModel _authViewModel = AuthViewModel();
  List<EventForMobileResponse> eventist = [];
  List<EventForMobileResponse> upcommingEventList = [];

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  late String eventNameTitle = "";
  late double blockSizeVertical;
  static Widget _presentIcon(String day) => CircleAvatar(
    backgroundColor: Colors.green,
    child: Text(
      day,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    if(schoolId == null){
      schoolId = 0;
    }
    _getEventDetail(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    var screenHeight = MediaQuery.of(context).size.height;
    blockSizeVertical = screenHeight / 100;
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(() => selectedDate = date);
        events.forEach((event) => event.title != null
            ? bottomMenu(event.title!, selectedDate, event.getIcon())
            : Container());
      },
      showOnlyCurrentMonthDate: false,

      weekendTextStyle: TextStyle(
        color: Colors.black87,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.narrow,
      weekdayTextStyle: TextStyle(
        color: HexColor("#6462AA")
      ),
      markedDatesMap: _markedDateMap,
      height: blockSizeVertical * 35,
      selectedDateTime: selectedDate,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayButtonColor: HexColor("#6462AA"),
      selectedDayTextStyle: TextStyle(
        color: HexColor("#6462AA"),
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

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
                        child: Text(LabelStr.lblEvents,
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
              top: MediaQuery.of(context).size.height * 0.14,
              left: MediaQuery.of(context).size.height * 0.03,
              right: MediaQuery.of(context).size.height * 0.03,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                color: HexColor("FAFAFA"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: blockSizeVertical * 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        // bottomMenu();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor("#6462AA")
                              ),
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Upcoming Events",
                              style: AppTheme.regularTextStyle().copyWith(
                                  fontSize: 16,
                                  color: Color.fromRGBO(11, 11, 11, 1)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: upcommingEventList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(top: 10),
                        itemBuilder: (BuildContext context, int position){
                          return _listRowItem(context, position);
                        })
                  ],
                ),
              )),
        ],
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
            if(isSuccess){
              upcommingEventList.add(eventist[i]);
            }
            eventNameTitle = eventist[i].eventName;
            String date = Utils.convertDate(
                eventist[i].fromDateTime, DateFormat('MM/dd/yyyy'));
            print(date);
            var dateInFormatText = date.split("/");
            setState(() {
              _markedDateMap.add(
                DateTime(
                      int.parse(dateInFormatText[2]),
                      int.parse(dateInFormatText[0]),
                      int.parse(dateInFormatText[1])),
                Event(
                      date: new DateTime(
                          int.parse(dateInFormatText[2]),
                          int.parse(dateInFormatText[0]),
                          int.parse(dateInFormatText[1])),
                      title: eventist[i].eventName,
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 0),
                        child: Container(
                          child: Html(
                            data: "Event Details:" + "\n" + eventist[i].eventDetail,
                              defaultTextStyle: AppTheme.regularTextStyle().copyWith(
                                  fontSize: 16, color: Colors.black54)),
                        ),
                      ))
              );
            });
          }
        });
      } else {
        Utils.showToast(context, message, Colors.red);
      }
    });
  }

  _isUpcommingEvent(String fromDateTime) {
    var now = DateTime.now();
    var eventDate = DateTime.parse(fromDateTime);
    if(now.isBefore(eventDate)){
      return true;
    } else {
      return false;
    }
  }

  _listRowItem(BuildContext context, int position) {

    return InkWell(
      onTap: (){
        var circle = Container(
          padding: EdgeInsets.fromLTRB(20.0, 0, 10, 0),
          child: Html(
              data: "Event Details:" + "\n" + upcommingEventList[position].eventDetail,
              defaultTextStyle: AppTheme.regularTextStyle().copyWith(
                  fontSize: 16, color: Colors.black54)),
        );
        bottomMenu(upcommingEventList[position].eventName, DateTime.parse(upcommingEventList[position].fromDateTime), circle);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(upcommingEventList[position].eventName, style: AppTheme.regularTextStyle()),
            Text(Utils.convertDate(upcommingEventList[position].fromDateTime, DateFormat("MM/dd/yyyy")), style: AppTheme.customTextStyle(MyFont.SSPro_regular, 14.0, Colors.black54)),
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

  void bottomMenu(String eventist, DateTime currentDate2, Widget? abcd) {
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(currentDate2);
    String finalDate =
        Utils.convertDate(formattedDate, DateFormat("dd-MM-yyyy"));
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
                    child: Text(eventist,
                        style: AppTheme.customTextStyle(MyFont.SSPro_semibold,
                            18.0, Color.fromRGBO(0, 0, 0, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                    child: Text(
                      "Date & Time:" + "\n" + finalDate,
                      style: AppTheme.regularTextStyle()
                          .copyWith(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  abcd!,
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Divider(
                        thickness: 1, color: Color.fromRGBO(223, 223, 223, 4)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 10, bottom: 20),
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
}
