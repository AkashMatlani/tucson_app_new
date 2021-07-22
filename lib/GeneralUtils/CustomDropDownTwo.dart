import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/Model/GetAllReasonModel.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ColorExtension.dart';


class CustomDropDownListTwo extends StatefulWidget {

  String schoolName;
  GetAllReasonModel response;
  List<GetAllReasonModel> schoolList;

  CustomDropDownListTwo(this.schoolName, this.response, this.schoolList);

  @override
  _CustomDropDownListState createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownListTwo> {

  var _filterController = TextEditingController();
  List<GetAllReasonModel> filterList = [];
  int selectPosition = -1;

  @override
  void initState() {
    super.initState();
    filterList.addAll(widget.schoolList);
    setState(() {
      if(widget.schoolName.compareTo('select_reason_for_service_request'.tr()) == 0){
        _filterController.text = "";
      } else {
        _filterController.text = widget.schoolName;
        Timer(Duration(milliseconds: 50), (){
          for(int i=0; i<widget.schoolList.length; i++){
            if(widget.schoolList[i].reason.compareTo(widget.schoolName) == 0){
              setState(() {
                selectPosition = i;
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search_service_request'.tr(),
                        hintStyle: AppTheme.regularTextStyle(),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _filterController,
                      onChanged: (value){
                        setState(() {
                          if(value.length >= 3){
                            filterList = widget.schoolList.where((itemDetails) {
                              return itemDetails.reason.toLowerCase().contains(value.toLowerCase());
                            }).toList();
                          } else {
                            filterList = widget.schoolList;
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      if(_filterController.text.isEmpty){
                        Navigator.of(context).pop(null);
                      } else {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _filterController.text = "";
                          filterList = widget.schoolList;
                          selectPosition = -1;
                        });
                      }
                    },
                    icon: Icon(Icons.clear, size: 24, color: Colors.black54),
                  )
                ],
              ),
              Container(
                height: 2,
                color: Colors.black54,
              ),
              SizedBox(height: 10),
              filterList.length > 0 ? Expanded(
                child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: filterList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (BuildContext context, int position){
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor("#6462AA"), width: 1),
                              color: position == selectPosition ? HexColor("#e0dfee") : HexColor("#fbfbfb")
                          ),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(filterList[position].reason, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: HexColor("#6462AA"))),
                        ),
                        onTap: (){
                          Navigator.of(context).pop(filterList[position]);
                        },
                      );
                    }
                ),
              ) : emptyListView(),
            ],
          ),
        ),
      ),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height*0.88,
      child: Text('no_service_request'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }
}
