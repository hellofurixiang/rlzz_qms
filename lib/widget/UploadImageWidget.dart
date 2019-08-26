import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/net/MethodChannelUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/FilePicker.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class UploadImageWidget extends StatefulWidget {
  final String enclosure;

  ///图片列表
  final List<Enclosure> enclosures;

  ///是否显示拍照上传按钮
  final bool isShowAddPhotoBtn;

  ///显示图片控件宽度
  final double width;

  ///图片上传成功回调方法
  final Function uploadSuccessFun;

  UploadImageWidget(
      this.enclosure, this.enclosures, this.isShowAddPhotoBtn, this.width,
      {Key key, this.uploadSuccessFun});

  @override
  State<StatefulWidget> createState() => UploadImageWidgetState();
}

class UploadImageWidgetState extends State<UploadImageWidget> {
  bool isChoose = false;

  @override
  void initState() {
    super.initState();
    //getPicturesListBytes();
    getImagesInfo();
    isChoose = widget.isShowAddPhotoBtn;
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///文件类型
  FileType _fileType = FileType.IMAGE;

  getImagesInfo() {
    if (widget.enclosures.length == 0) {
      if (CommonUtil.isNotEmpty(widget.enclosure)) {
        List<Enclosure> badPictures = List();
        List arr = json.decode(widget.enclosure.replaceAll('\'', '"'));
        arr.forEach((f) {
          badPictures.add(Enclosure.fromJson(f));
        });
        setState(() {
          widget.enclosures.addAll(badPictures);
        });
      }
    }
  }

  ///获取照片
  Future getImage(ImageSource imageSource) async {
    ///获取多个图片
    if (imageSource == ImageSource.gallery) {
      List<Enclosure> _list = [];

      Map<String, String> _paths =
          await FilePicker.getMultiFilePath(type: _fileType);
      _paths.forEach((fileName, filePath) {
        File _file = File(filePath);

        Enclosure en = new Enclosure.empty()
          ..localFile = _file
          ..path = filePath
          ..size = _file.lengthSync().toString()
          ..name = _file.path.substring(_file.parent.path.length + 1);
        _list.add(en);
      });
      setState(() {
        widget.enclosures.addAll(_list);
        isChoose = true;
      });
    } else {
      File image = await ImagePicker.pickImage(source: imageSource);

      if (image == null) {
        //currentSelected = "not select item";
        Fluttertoast.showToast(
            msg: StringZh.selectPhotoError, timeInSecForIos: 3);
        return;
      }
      Enclosure en = new Enclosure.empty()
        ..localFile = image
        ..path = image.path
        ..size = image.lengthSync().toString()
        ..name = image.path.substring(image.parent.path.length + 1);
      setState(() {
        widget.enclosures.add(en);
        isChoose = true;
      });
    }
  }

  ///图片上传
  _uploadImages() async {
    WidgetUtil.showLoadingDialog(context, StringZh.uploading);
    ApiUtil.uploadImageList(context, widget.enclosures, () {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: StringZh.photoUploadFinish, timeInSecForIos: 3);
      setState(() {
        isChoose = false;
      });
    }, () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    if (widget.isShowAddPhotoBtn) {
      List<Widget> rowList = [];

      rowList.add(new Container(
        width: 150.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                getImage(ImageSource.camera);
              },
              child: new Container(
                alignment: Alignment.center,
                width: 60.0,
                height: 30.0,
                child: new Text(
                  StringZh.camera,
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: RLZZColors.mainColor,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(6.0),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              child: new Container(
                alignment: Alignment.center,
                width: 60.0,
                height: 30.0,
                child: new Text(
                  StringZh.gallery,
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: RLZZColors.mainColor,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(6.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ));

      if (isChoose) {
        rowList.add(new GestureDetector(
          onTap: () {
            _uploadImages();
          },
          child: new Container(
            alignment: Alignment.center,
            width: 60.0,
            height: 30.0,
            child: new Text(
              StringZh.upload,
              style: new TextStyle(
                  fontSize: RLZZConstant.normalTextSize, color: Colors.white),
            ),
            decoration: new BoxDecoration(
              color: RLZZColors.mainColor,
              borderRadius: new BorderRadius.all(
                new Radius.circular(6.0),
              ),
            ),
          ),
        ));
      }

      list.add(new Container(
        alignment: Alignment.centerLeft,
        //margin: new EdgeInsets.only(top: 10.0),
        padding: new EdgeInsets.only(left: 10.0, right: 10.0),
        //color: RLZZColors.itemBodyColor,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowList,
        ),
      ));
    }

    list.add(new Container(
      height: widget.enclosures.length == 0 ? 30.0 : 250.0,
      padding: new EdgeInsets.all(10.0),
      margin: new EdgeInsets.only(top: 10.0),
      color: RLZZColors.itemBodyColor,
      child: new GridView.builder(
          itemCount: widget.enclosures.length,
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(

              ///SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item
              ///SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item

              //单个子Widget的水平最大宽度
              maxCrossAxisExtent: 300,
              //水平单个子Widget之间间距
              mainAxisSpacing: 20.0,
              //垂直单个子Widget之间间距
              crossAxisSpacing: 10.0,

              //子组件宽高长度比例
              childAspectRatio: 6),
          itemBuilder: (BuildContext context, int index) {
            return getItem(index);
          }),
    ));

    return new Container(
      margin: new EdgeInsets.only(top: 10.0, bottom: 30.0),
      alignment: Alignment.center,
      child: new Column(
        children: list,
      ),
    );
  }

  Widget getItem(int index) {
    Enclosure f = widget.enclosures[index];

    return new GestureDetector(
      onLongPress: () {
        WidgetUtil.showConfirmDialog(context, StringZh.deleteImageTip, () {
          setState(() {
            widget.enclosures.removeAt(index);
          });
        }, confirmText: StringZh.yes, cancelText: StringZh.no);
      },
      onTap: () async {
        if (null == f.id) {
          openFile(f);
        } else {
          ///获取文件路径
          String filePath = await CommonUtil.getFilePath(f);
          File file = File(filePath);

          ///判断文件是否已经存在，存在直接打开
          bool bo = await file.exists();
          if (bo) {
            f.path = filePath;
            openFile(f);
          } else {
            WidgetUtil.showLoadingDialog(context, StringZh.imageLoading);

            ///下载文件，并打开
            ApiUtil.downloadFile(context, f, (bo) {
              Navigator.pop(context);
              if (bo) {
                /*WidgetUtil.showConfirmDialog(context, StringZh.downloadFinishTip,
                  () {*/
                openFile(f);
                //}, confirmText: StringZh.yes, cancelText: StringZh.no);
              }
            }, (err) {
              Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
              Navigator.pop(context);
            });
          }
        }
      },
      child: new Container(
        color: Colors.transparent,
        //margin: EdgeInsets.all(5.0),
        child: new ListTile(
          leading: Image.asset(
            CommonUtil.selectIcon(f.name),
            height: 40.0,
            width: 40.0,
          ),
          title: new Text(
            f.name,
            style: TextStyle(fontSize: 14.0),
          ),
          subtitle: Text(
            CommonUtil.getFileSize(int.parse(f.size)),
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  void openFile(Enclosure f) {
    MethodChannelUtil.openFile(f.path);
  }
}
