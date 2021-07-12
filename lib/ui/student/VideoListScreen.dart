import 'package:ext_storage/ext_storage.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/VideoPlayerScreen.dart';
import 'package:tucson_app/ui/community/VideoPlayerScreen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';



class VideoListScreen extends StatefulWidget {

  VideoListScreen(this.title);
  String title;

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {

  bool isLoading = true;
  String? languageCode;
  List<ContentTransactionResponse> _videoList = [];

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(schoolId == null){
      schoolId = 0;
    }
    _getContentList(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: HexColor("#6462AA"),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
                  height: MediaQuery.of(context).size.height*0.06,
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
                        child: Text(widget.title,
                            style: AppTheme.regularTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: HexColor("FAFAFA")),
                  height: MediaQuery.of(context).size.height*0.88,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.12,
            left: MediaQuery.of(context).size.height*0.012,
            right: MediaQuery.of(context).size.height*0.012,
            child: Container(
              height: MediaQuery.of(context).size.height*0.88,
              child: _videoList.length == 0 ? emptyListView() : SingleChildScrollView(
                child:  ListView.builder(
                    itemCount: _videoList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int position){
                      return _listRowItems(context, position);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if(_videoList[index].objectPath.contains("https://www.youtube.com/")){
          Utils.navigateToScreen(context, DisplayWebview(_videoList[index].objectPath));
        }else {
          Utils.navigateToScreen(context, VideoPlayerScreenOne(_videoList[index].objectPath));
        }
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height*0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              alignment: Alignment.center,
              child: Image.asset(MyImage.videoUrlImage, fit: BoxFit.fill),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 20),
                child: Text(
                    _videoList[index].objectName,
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_bold,
                        20.0,
                        Color.fromRGBO(0, 0, 0, 1))))
          ]),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height*0.88,
      child: isLoading ? Container() : Text('no'.tr()+" "+widget.title+" "+'found'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _getContentList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "Video"
    };

    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, (isSuccess, message){
      if(isSuccess){
        setState(() {
          _videoList = [];
          for(var data in _contentViewModel.contentList){
            for(var innerData in data.contentTransactionTypeJoin){
              if(innerData.contentTransTypeName.compareTo("Video") == 0){
                _videoList.add(innerData);
              }
            }
          }
        });
        translateListData();
      } else {
        Utils.showLoader(false, context);
        isLoading = false;
        setState(() {
          _videoList = [];
        });
      }
    });
  }

  translateListData(){
    List<String> nameList=[];
    List<ContentTransactionResponse> tempList =[];
    for(var items in _videoList){
      nameList.add(items.objectName);
    }
    String nameStr = nameList.join("==)");
    WebService.translateApiCall(languageCode!, nameStr, (isSuccess, response){
      if(isSuccess){
        List<String> resultArr = response.toString().split("==)");
        for(int i=0; i< resultArr.length; i++){
          tempList.add(ContentTransactionResponse(contentTransactionId: _videoList[i].contentTransactionId,
              contentMasterId: _videoList[i].contentMasterId,
              contentTransTypeId: _videoList[i].contentTransTypeId,
              objectName: resultArr[i],
              objectPath: _videoList[i].objectPath,
              contentTransTypeName: _videoList[i].contentTransTypeName));
        }
        setState(() {
          _videoList = [];
          _videoList.addAll(tempList);
        });
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      isLoading = false;
      Utils.showLoader(false, context);
    });
  }

  late String path="";
  getVideoThumbinail() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      /*    if (io.Platform.isIOS) {
        io.Directory appDocDirectory;
        appDocDirectory = await getApplicationDocumentsDirectory();
        Directory directory= await new Directory(appDocDirectory.path+'/'+'Download').create(recursive: true);
        String path=directory.path.toString();
        File file = new File('$path/$filename');
        ToastUtils.showToast(context, "Your file save at "+file.toString()+" location", Colors.green);
        await file.writeAsBytes(bytes);
        return file;
      }
      else{*/
      path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
      // File file = new File('$path/$filename');
      // ToastUtils.showToast(context, "Your file save at "+file.toString()+" location", Colors.green);
      //await file.writeAsBytes(bytes);
      // return file;
    } else {
      Map<Permission, PermissionStatus> status = await [
        Permission.storage,
      ].request();
      print("Permission status :: $status");
    }

    String? fileName;
    try {
      fileName = await VideoThumbnail.thumbnailFile(
        video: _videoList[0].objectPath,
        thumbnailPath: path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 240,
        quality: 50,
      );
    } catch (e) {
      print(e);
      fileName = "";
    }
    return fileName;
  }
}
