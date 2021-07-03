import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/Model/EventForMobileResponse.dart';
import 'package:tucson_app/Model/GridListItems.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class CalendarEvent extends StatefulWidget {
  @override
  _CalendarEventState createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  String _currentMonth = DateFormat.yMMM().format(DateTime(2021,7, 3));
  DateTime _targetDateTime = DateTime(2021, 7, 3);
  DateTime _currentDate = DateTime(2021, 7, 3);
  DateTime _currentDate2 = DateTime(2021, 7, 3);

  AuthViewModel _authViewModel = AuthViewModel();
  late List<EventForMobileResponse> eventist = [];
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblEducationWebstite,
      svgPicture: MyImage.educationalWebsiteIcon,
    ),
    GridListItems(name: LabelStr.lblVideos, svgPicture: MyImage.videosIcon),
    GridListItems(
        name: LabelStr.lblActivites, svgPicture: MyImage.activitesIcon),
    GridListItems(name: LabelStr.lblArticles, svgPicture: MyImage.articlesIcon),
    GridListItems(name: LabelStr.lblBlogs, svgPicture: MyImage.blogsIcon),
  ];

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  late String eventNameTitle = "";

  @override
  void initState() {
    Timer(Duration(milliseconds: 100), () => _getEventDetail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) =>
        event.title!=null?
            bottomMenu(event.title!, _currentDate2, event.getIcon()):Container());
      },
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.blue)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
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
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
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
              top: MediaQuery.of(context).size.height * 0.20,
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
                    //custom icon
                    // This trailing comma makes auto-formatting nicer for build methods.
                    //custom icon without header
                    Container(
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
                                    style: AppTheme.regularTextStyle().copyWith(color: HexColor("#6462AA")),
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
                          SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.height*0.33,
                            child: _calendarCarouselNoHeader,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // bottomMenu();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Upcoming Event",
                          style: AppTheme.regularTextStyle().copyWith(
                              fontSize: 16,
                              color: Color.fromRGBO(11, 11, 11, 1)),
                        ),
                      ),
                    )
                    //
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _getEventDetail() {
    Utils.showLoader(true, context);
    _authViewModel.getAllEventForMobile("1", (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          eventist = _authViewModel.eventForMobileList;
          for (int i = 0; i < eventist.length; i++) {
            eventNameTitle = eventist[i].eventName;
            String date = Utils.convertDate(
                eventist[i].fromDateTime, DateFormat('MM/dd/yyyy'));

            print(date);
            var dateInFormatText = date.split("/");
            _eventIcon;
            setState(() {
              _markedDateMap.add(
                  new DateTime(
                      int.parse(dateInFormatText[2]),
                      int.parse(dateInFormatText[0]),
                      int.parse(dateInFormatText[1])),
                  new Event(
                      date: new DateTime(
                          int.parse(dateInFormatText[2]),
                          int.parse(dateInFormatText[0]),
                          int.parse(dateInFormatText[1])),
                      title: eventist[i].eventName,
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
                        child: Container(
                          child: Text("Event Details:"+"\n"+eventist[i].eventDetail,
                              style: AppTheme.regularTextStyle().copyWith(
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 0, 0, 1))),
                        ),
                      )));
            });
          }
        });
      } else {
        Utils.showToast(context, message, Colors.red);
      }
    });
  }

  static Widget _eventIcon = new Container(
    child: new Text("abcdpqrs"),
  );

  void bottomMenu(String eventist, DateTime currentDate2, Widget? abcd) {


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40, 10, 10),
              child: Text(eventist,
                  style: AppTheme.customTextStyle(
                      MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
              child: Text(
                currentDate2.toString(),
                style: AppTheme.regularTextStyle()
                    .copyWith(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ),
            abcd!,
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Divider(
                  thickness: 1, color: Color.fromRGBO(223, 223, 223, 4)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(204, 204, 204, 1)),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: TextButton(
                    child: Text(LabelStr.lblCancel,
                        style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0,
                            Color.fromRGBO(255, 255, 255, 1))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
