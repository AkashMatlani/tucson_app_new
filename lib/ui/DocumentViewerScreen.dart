import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';

class DocumentViewerScreen extends StatefulWidget {

  String imagePath;
  DocumentViewerScreen(this.imagePath);

  @override
  _DocumentViewerScreenState createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FileReaderView(
            filePath: widget.imagePath,
          )
      ),
    );
  }
}
