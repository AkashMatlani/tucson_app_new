import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/Model/EventForMobileResponse.dart';

class EventDetailsScreen extends StatefulWidget {

  EventDetailsScreen(this.sameDayEventList);
  List<EventForMobileResponse> sameDayEventList;

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
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
                                  Navigator.of(context).pop();
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('event_details'.tr(),
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
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: widget.sameDayEventList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int position){
                      return _listRowItems(ctx, position);
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    String resFromDate = widget.sameDayEventList[index].fromDateTime.split('T')[0];
    DateTime utcFromDate = DateTime.parse(resFromDate).toUtc();
    var localFromDate = utcFromDate.toLocal();
    String strUtcFromDate = DateFormat("MM/dd/yyyy").format(localFromDate);
    String fromDate = strUtcFromDate+" "+widget.sameDayEventList[index].startTime;

    String resToDate = widget.sameDayEventList[index].toDateTime.split('T')[0];
    DateTime utcToDate = DateTime.parse(resToDate).toUtc();
    var localToDate = utcToDate.toLocal();
    String strUtcToDate = DateFormat("MM/dd/yyyy").format(localToDate);
    String toDate = strUtcToDate+" "+widget.sameDayEventList[index].endTime;


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
          Text(widget.sameDayEventList[index].eventName, style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
          SizedBox(height: 5),
          Text(
            'start_date_time'.tr() +": "+ fromDate,
            style: AppTheme.regularTextStyle()
                .copyWith(fontSize: 16, color: Colors.black54),
          ),
          Text(
            'end_date_time'.tr() +": "+ toDate,
            style: AppTheme.regularTextStyle()
                .copyWith(fontSize: 16, color: Colors.black54),
          ),
          Text('total_day'.tr()+ ': '+getDayCount(localFromDate, localToDate), style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
          SizedBox(height: 10),
          Text('event_details'.tr()+ ':', style: AppTheme.regularTextStyle().copyWith(fontSize: 16, color: Colors.black54)),
          Html(
            data: widget.sameDayEventList[index].eventDetail,
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
}
