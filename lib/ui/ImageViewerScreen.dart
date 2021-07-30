import 'package:cached_network_image/cached_network_image.dart';
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
  late double screenWidth;
  late double screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;
  late MediaQueryData? _mediaQueryData;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#6462AA"),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Center(
          child: Container(
              height: blockSizeVertical * 100,
              width: blockSizeHorizontal * 100,
              /* child: PhotoView(
              imageProvider: NetworkImage(widget.imagePath),
            )*/
              child: CachedNetworkImage(
                imageUrl: widget.imagePath,
                placeholder: (context, url) => Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Center(
                    child: SizedBox(
                        width: 30, height: 10, child: Icon(Icons.error))),
              )),
        ));
  }
}
