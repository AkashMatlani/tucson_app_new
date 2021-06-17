import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      Container(
      padding: EdgeInsets.only(
          top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
      child: Text(
        'Hello',
        style: TextStyle(
          color: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
            Flexible(
              flex: 1,
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Sign Up",style: TextStyle(color: Color(0xff3A3A3A)),)
                  ],
                ),
              ),
            ),
          ],
      ),
   );
  }
}

