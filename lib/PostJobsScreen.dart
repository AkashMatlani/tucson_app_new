import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'GeneralUtils/ColorExtension.dart';
import 'GeneralUtils/Constant.dart';
import 'GeneralUtils/HelperWidgets.dart';
import 'GeneralUtils/LabelStr.dart';
import 'GeneralUtils/Utils.dart';

class PostJobsScreen extends StatefulWidget {
  @override
  _PostJobsScreenState createState() => _PostJobsScreenState();
}

class _PostJobsScreenState extends State<PostJobsScreen> {

  String _userType = 'Student';

  var _label2Controller = TextEditingController();
  var _label3Controller = TextEditingController();
  var _label4Controller = TextEditingController();
  var _label5Controller = TextEditingController();
  var _label6Controller = TextEditingController();
  var _label7Controller = TextEditingController();
  var _label8Controller = TextEditingController();
  DateTime currentDate = DateTime.now();

  bool _showPwd = false;
  bool _showConfPwd = false;

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
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
                       child: Text(LabelStr.lblPostJob,
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
           top: MediaQuery.of(context).size.height*0.12,
           left: MediaQuery.of(context).size.height*0.012,
           right: MediaQuery.of(context).size.height*0.012,
           child: Container(
             margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
             height: MediaQuery.of(context).size.height*0.88,
             child: SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Label1", style: AppTheme.regularTextStyle().copyWith(color: MyColor.hintTextColor())),
                   DropdownButton<String>(
                     value: _userType,
                     isExpanded: true,
                     itemHeight: 50,
                     underline: Container(
                       height: 1.3,
                       color: Colors.black45,
                     ),
                     style: AppTheme.regularTextStyle(),
                     icon: Icon(                // Add this
                       Icons.keyboard_arrow_down,
                       color: HexColor("#CCCCCC"),// Add this
                     ),
                     items: <DropdownMenuItem<String>>[
                       DropdownMenuItem(
                         child: Text(LabelStr.lblStudent),
                         value: 'Student',
                       ),
                       DropdownMenuItem(
                           child: Text(LabelStr.lblParent),
                           value: 'Parent'
                       ),
                       DropdownMenuItem(
                           child: Text(LabelStr.lblCommunity),
                           value: 'Community'
                       )
                     ],
                     onChanged: (value){
                       setState(() {
                         _userType = value.toString();
                       });
                     },
                   ),
                   SizedBox(height: 20),
                   Text("Label2", style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor("label2", _label2Controller, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                   SizedBox(height: 20),
                   Text("Label3", style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor("label3", _label3Controller, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                   SizedBox(height: 20),
                   Text(LabelStr.lbldob, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor(LabelStr.lbldob, _label4Controller, readOnly: true, suffixIcon: InkWell(onTap:(){_selectDate(context);},child: Icon(Icons.calendar_today_outlined, size: 24))),
                   SizedBox(height: 20),
                   Text("Label4", style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor("label4", _label5Controller, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                   SizedBox(height: 20),
                   Text("Label5", style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor("label5", _label6Controller, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                   SizedBox(height: 20),
                   Text(LabelStr.lblPassword, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor(LabelStr.lblPassword, _label7Controller, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showPwd, suffixIcon: InkWell(onTap:(){_togglePwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                   SizedBox(height: 20),
                   Text(LabelStr.lblConfirmPwd, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                   textFieldFor(LabelStr.lblConfirmPwd, _label8Controller, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showConfPwd, suffixIcon: InkWell(onTap:(){_toggleConfPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                   SizedBox(height: 30),
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
                       child: Text(LabelStr.lblSubmit, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                       onPressed: (){
                         print("text");
                       },
                     ),
                   ),
                   SizedBox(height: 50)
                 ],
               ),
             ),
           ),
         )
       ],
     ),
   );
  }

  void _togglePwd() {
    setState(() {
      _showPwd = !_showPwd;
    });
  }

  void _toggleConfPwd() {
    setState(() {
      _showConfPwd = !_showConfPwd;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1960),
        lastDate: currentDate);
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        String formattedDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(currentDate);
        _label4Controller.text = Utils.convertDate(formattedDate, DateFormat("MM-dd-yyyy"));
      });
  }
}

