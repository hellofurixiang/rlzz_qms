import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ImageListWidget.dart';

///选择图片控件
class SelectImageWidget extends StatefulWidget {
  ///图片列表
  final List<Enclosure> enclosures;

  ///是否显示拍照上传按钮
  final bool isShowAddPhotoBtn;

  ///显示图片控件宽度
  final double width;

  ///图片上传成功回调方法
  final Function uploadSuccessFun;

  SelectImageWidget(this.enclosures, this.isShowAddPhotoBtn, this.width,
      {Key key, this.uploadSuccessFun});

  @override
  State<StatefulWidget> createState() => SelectImageWidgetState();
}

class SelectImageWidgetState extends State<SelectImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool isChoose = false;

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
      child: new ImageListWidget(
        widget.enclosures,
        isShowRemove: true,
        width: 150.0, //widget.width,
      ),
    ));

    return new Container(
      margin: new EdgeInsets.only(top: 10.0, bottom: 30.0),
      alignment: Alignment.center,
      child: new Column(
        children: list,
      ),
    );
  }

  ///图片上传
  _uploadImages() async {
    WidgetUtil.showLoadingDialog(context, StringZh.uploading);
    ApiUtil.uploadImageList(context, widget.enclosures, () {
      Navigator.pop(context);
      if (null != widget.uploadSuccessFun) {
        widget.uploadSuccessFun();
      }
      setState(() {
        isChoose = false;
      });
    }, () {
      Navigator.pop(context);
    });
  }

  ///获取照片
  Future getImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);

    if (image == null) {
      //currentSelected = "not select item";
    } else {
      Enclosure en = new Enclosure.empty();

      en.localFile = image;
      en.path = image.path;
      en.name = image.path.substring(image.parent.path.length + 1);

      /* WidgetUtil.showLoadingDialog(context, StringZh.uploading);
      ApiUtil.uploadImages(en, () {
        Navigator.pop(context);
        setState(() {
          widget.enclosures.add(en);
        });
        if (null != widget.uploadSuccessFun) {
          widget.uploadSuccessFun();
        }
        */ /*setState(() {
          isChoose = false;
        });*/ /*
      }, () {
        Navigator.pop(context);
      });*/

      setState(() {
        widget.enclosures.add(en);
        isChoose = true;
      });
    }
  }
}
