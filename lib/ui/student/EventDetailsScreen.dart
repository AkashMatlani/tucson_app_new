import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/EventForMobileResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';


class EventDetailsScreen extends StatefulWidget {

  EventDetailsScreen(this.event, this.eventList);
  Event event;
  List<EventForMobileResponse> eventList;

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {

  List<EventForMobileResponse> sameDayEventList = [];

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), (){
      String tempDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(widget.event.date);
      String selectedDate = tempDate.split('T')[0];
      List<EventForMobileResponse>  tempList = [];
      for(int i=0; i<widget.eventList.length; i++){
        String fromDate = widget.eventList[i].fromDateTime.split('T')[0];
        if(fromDate.compareTo(selectedDate) == 0){
          tempList.add(widget.eventList[i]);
        }
      }
      setState(() {
        sameDayEventList = tempList;
      });
      getLanguageCode();
    });
  }

  getLanguageCode() async {
    String languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(languageCode == null){
      languageCode = "en";
    }
    if(languageCode.compareTo("en") != 0){
      _translateEventDetails(languageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for(int i=0; i< sameDayEventList.length; i++){
          Navigator.of(context)..pop();
        }
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                                  for(int i=0; i< sameDayEventList.length; i++){
                                    Navigator.of(context)..pop();
                                  }
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('event_details'.tr(),
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
                  child: sameDayEventList.length > 0 ? ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: sameDayEventList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, int position){
                        return _listRowItems(ctx, position);
                      }
                  ) : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    String resFromDate = sameDayEventList[index].fromDateTime.split('T')[0];
    DateTime utcFromDate = DateTime.parse(resFromDate).toUtc();
    var localFromDate = utcFromDate.toLocal();
    String strUtcFromDate = DateFormat("MM/dd/yyyy").format(localFromDate);
    String fromDate = strUtcFromDate+" "+sameDayEventList[index].startTime;

    String resToDate = sameDayEventList[index].toDateTime.split('T')[0];
    DateTime utcToDate = DateTime.parse(resToDate).toUtc();
    var localToDate = utcToDate.toLocal();
    String strUtcToDate = DateFormat("MM/dd/yyyy").format(localToDate);
    String toDate = strUtcToDate+" "+sameDayEventList[index].endTime;


    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white, border: Border.all(color: HexColor("#6462AA"), width: 0.5)),
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(sameDayEventList[index].eventName, style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
          SizedBox(height: 5),
          Text(
            'start_date_time'.tr() +": "+fromDate,
            style: AppTheme.regularTextStyle()
                .copyWith(fontSize: 16, color: Colors.black54),
          ),
          Text(
            'end_date_time'.tr() +": "+toDate,
            style: AppTheme.regularTextStyle()
                .copyWith(fontSize: 16, color: Colors.black54),
          ),
          Text('total_day'.tr()+ ': '+getDayCount(localFromDate, localToDate), style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
          SizedBox(height: 10),
          Text('event_details'.tr()+ ':', style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
          Html(
            data: sameDayEventList[index].eventDetail,
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

  _translateEventDetails(String languageCode){
    Utils.showLoader(true, context);
    List<String> detailsList = [];
    List<EventForMobileResponse> tempList =[];
    for(var items in sameDayEventList){
      detailsList.add(items.eventDetail);
    }
    String data = tempList.join("===");
    WebService.translateApiCall(languageCode, data, (isSuccess, response) {
      if(isSuccess){
        List<String> responseArray = response.toString().split("===");
        for(int i=0; i<responseArray.length; i++){
          tempList.add(EventForMobileResponse(
              tusdEventId: sameDayEventList[i].tusdEventId,
              schoolId: sameDayEventList[i].schoolId,
              eventTypeId: sameDayEventList[i].eventTypeId,
              eventName: responseArray[i],
              fromDateTime: sameDayEventList[i].fromDateTime,
              toDateTime: sameDayEventList[i].toDateTime,
              eventDetail: sameDayEventList[i].eventDetail,
              freeFields1: sameDayEventList[i].freeFields1,
              freeFields2: sameDayEventList[i].freeFields2,
              freeFields3: sameDayEventList[i].freeFields3,
              freeFields4: sameDayEventList[i].freeFields4,
              isActive: sameDayEventList[i].isActive,
              shareMode: sameDayEventList[i].shareMode,
              createdBy: sameDayEventList[i].createdBy,
              createdOn: sameDayEventList[i].createdOn,
              updatedBy: sameDayEventList[i].updatedBy,
              updatedOn: sameDayEventList[i].updatedOn,
              eventTypeName: sameDayEventList[i].eventTypeName,
              schoolName: sameDayEventList[i].schoolName,
              startTime: sameDayEventList[i].startTime,
              endTime: sameDayEventList[i].endTime,
              schoolIds: sameDayEventList[i].schoolIds
          ));
        }
        if (sameDayEventList.length == tempList.length) {
          setState(() {
            sameDayEventList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      Utils.showLoader(false, context);
    });
  }
}
