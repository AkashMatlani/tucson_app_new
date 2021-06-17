import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParentDashBoardScreen extends StatefulWidget {
  @override
  _ParentDashBoardScreenState createState() => _ParentDashBoardScreenState();
}

class _ParentDashBoardScreenState extends State<ParentDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Tucson App"),
        ),
      ),
    );
  }
}
