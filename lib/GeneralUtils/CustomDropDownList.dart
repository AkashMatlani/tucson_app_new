import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
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

    List<String> psrsm = ['Reens', 'Bsnk entrollrer', 'kadam', 'rahul', 'soniya', 'kamlesh', 'reena', 'mahesh'];
    var temp = psrsm.where((element) => element.contains("een")).toList();

    print("PSRM => ${temp}");

    filterList.addAll(widget.schoolList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'search_school'.tr(),
                    hintStyle: AppTheme.regularTextStyle(),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _filterController.text = "";
                          filterList = widget.schoolList;
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      icon: Icon(Icons.clear, size: 24, color: Colors.black54),
                    )
                  ),
                  keyboardType: TextInputType.text,
                  controller: _filterController,
                  onChanged: (value){
                    setState(() {
                      if(value.length >= 3){
                        filterList = widget.schoolList.where((itemDetails) {
                          return itemDetails.name.toLowerCase().contains(value.toLowerCase());
                        }).toList();
                        print("Length => ${filterList.length}");
                      } else {
                        filterList = widget.schoolList;
                      }
                    });
                  },
                ),
                filterList.length > 0 ? ListView.builder(
                    itemCount: filterList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (BuildContext context, int position){
                      return ListTile(
                        title: Text(filterList[position].name, style: AppTheme.regularTextStyle()),
                        onTap: (){
                          Navigator.of(context).pop(filterList[position]);
                        },
                      );
                    }
                ) : emptyListView(),
              ],
            ),
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
