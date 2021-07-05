import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';


class ResetPwdScreen extends StatefulWidget {
  @override
  _ResetPwdScreenState createState() => _ResetPwdScreenState();
}

class _ResetPwdScreenState extends State<ResetPwdScreen> {

  var _newPwdController = TextEditingController();
  var _confPwdController = TextEditingController();

  bool _showNewPwd = true;
  bool _showConfPwd = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _newPwdController.text = "123456789";
      _confPwdController.text = "123456789";
    });
  }

  void _toggleNewPwd() {
    setState(() {
      _showNewPwd = !_showNewPwd;
    });
  }

  void _toggleConfPwd() {
    setState(() {
      _showConfPwd = !_showConfPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              alignment: Alignment.topCenter,
              child: Image.asset(MyImage.passwordReset),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height*0.25,
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)
                    ),
                    color: HexColor("#f9f9f9")
                ),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(LabelStr.lblResetPwd, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                      SizedBox(height: 20),
                      Text(LabelStr.lblNewPwd, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                      textFieldFor(LabelStr.lblNewPwd, _newPwdController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showNewPwd, suffixIcon: InkWell(onTap:(){_toggleNewPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                      SizedBox(height: 10),Text(LabelStr.lblNewPwd, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                      textFieldFor(LabelStr.lblConfirmPwd, _confPwdController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showConfPwd, suffixIcon: InkWell(onTap:(){_toggleConfPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
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
                          child: Text(LabelStr.lblSubmit, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                          onPressed: (){
                            print("Submit");
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
}