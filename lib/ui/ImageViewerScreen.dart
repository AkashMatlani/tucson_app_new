import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';

class ImageViewerScreen extends StatefulWidget {

  String imagePath;
  ImageViewerScreen(this.imagePath);

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  HexColor("#6462AA"),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.imagePath),
          )
      ),
    );
  }
}
