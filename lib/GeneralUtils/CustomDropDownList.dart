import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:easy_localization/easy_localization.dart';


class CustomDropDownList extends StatefulWidget {

  String schoolName;
  SchoolListResponse response;
  List<SchoolListResponse> schoolList;

  CustomDropDownList(this.schoolName, this.response, this.schoolList);

  @override
  _CustomDropDownListState createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {

  var _filterController = TextEditingController();
  List<SchoolListResponse> filterList = [];

  @override
  void initState() {
    super.initState();
    filterList.addAll(widget.schoolList);
    setState(() {
      if(widget.schoolName.compareTo('select_school'.tr()) == 0){
        _filterController.text = "";
      } else {
        _filterController.text = widget.schoolName;
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
                        hintText: 'search_school'.tr(),
                        hintStyle: AppTheme.regularTextStyle(),
                      ),
                      keyboardType: TextInputType.text,
                      controller: _filterController,
                      onChanged: (value){
                        setState(() {
                          if(value.length >= 3){
                            filterList = widget.schoolList.where((itemDetails) {
                              return itemDetails.name.toLowerCase().contains(value.toLowerCase());
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
                        title: Text(filterList[position].name, style: AppTheme.regularTextStyle()),
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
      child: Text('no_school'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }
}
