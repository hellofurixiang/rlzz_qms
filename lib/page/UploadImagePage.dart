import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/net/MethodChannelUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/plugin/FilePicker.dart';
import 'package:qms/common/utils/plugin/ImagePicker.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';

class UploadImagePage extends StatefulWidget {
  final String enclosure;

  final List<Enclosure> images;

  ///是否显示拍照上传按钮
  final bool isShowAddPhotoBtn;

  UploadImagePage(this.enclosure, this.images, this.isShowAddPhotoBtn);

  @override
  State<StatefulWidget> createState() => UploadImagePageState();
}

class UploadImagePageState extends State<UploadImagePage> {
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
    if (widget.images.length == 0) {
      if (CommonUtil.isNotEmpty(widget.enclosure)) {
        List<Enclosure> badPictures = List();
        List arr = json.decode(widget.enclosure.replaceAll('\'', '"'));
        arr.forEach((f) {
          badPictures.add(Enclosure.fromJson(f));
        });
        setState(() {
          widget.images.addAll(badPictures);
        });
      }
    }
  }

  ///获取表头不良图片
  /*getPicturesListBytes() {
    if (widget.images.length == 0) {
      if (CommonUtil.isNotEmpty(widget.enclosure)) {
        List<Enclosure> badPictures = List();
        List arr = json.decode(widget.enclosure.replaceAll('\'', '"'));
        arr.forEach((f) {
          badPictures.add(Enclosure.fromJson(f));
        });
        //WidgetUtil.showLoadingDialog(context, StringZh.imageLoading);
        ApiUtil.downloadFileList(context, badPictures, () {
          //ApiUtil.getImageListBytes(badPictures, (data) {
          //Navigator.pop(context);

          ///更新列表状态
          setState(() {
            */ /*for (int i = 0; i < data.length; i++) {
              print(data[i]);
              badPictures[i].uint8list = data[i];
            }*/ /*
            widget.images.clear();
            widget.images.addAll(badPictures);
          });
        }, (err) {
          Fluttertoast.showToast(msg: '图片加载异常', timeInSecForIos: 3);
          //Navigator.pop(context);
        });
      }
    }
  }*/

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
        widget.images.addAll(_list);
        isChoose = true;
      });
    } else {
      File image = await ImagePicker.pickImage(source: imageSource);

      if (image == null) {
        //currentSelected = "not select item";
        Fluttertoast.showToast(msg: '选择图片异常', timeInSecForIos: 3);
        return;
      }
      Enclosure en = new Enclosure.empty()
        ..localFile = image
        ..path = image.path
        ..size = image.lengthSync().toString()
        ..name = image.path.substring(image.parent.path.length + 1);
      setState(() {
        widget.images.add(en);
        isChoose = true;
      });
    }
  }

  ///图片上传
  _uploadImages() async {
    WidgetUtil.showLoadingDialog(context, StringZh.uploading);
    ApiUtil.uploadImageList(context, widget.images, () {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: '图片上传完成', timeInSecForIos: 3);
      setState(() {
        isChoose = false;
      });
      Navigator.pop(context);
    }, () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //double width = CommonUtil.getScreenWidth(context);
    //double height = CommonUtil.getScreenHeight(context);

    ///操作按钮
    List<Widget> btnList = new List();

    ///拍照
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.mainColor,
      text: StringZh.camera,
      fontColor: Colors.white,
      clickFun: () {
        getImage(ImageSource.camera);
      },
    ));

    ///相册
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.mainColor,
      text: StringZh.gallery,
      fontColor: Colors.white,
      clickFun: () {
        getImage(ImageSource.gallery);
      },
    ));

    ///上传
    if (isChoose) {
      btnList.add(ButtonWidget(
        height: 30.0,
        width: 65.0,
        backgroundColor: RLZZColors.mainColor,
        text: StringZh.upload,
        fontColor: Colors.white,
        clickFun: () {
          _uploadImages();
        },
      ));
    }

    /*btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.darkGrey,
      text: StringZh.app_cancel,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));*/
    btnList.add(new Container(
      margin: EdgeInsets.only(left: 100.0),
      child: ButtonWidget(
        height: 30.0,
        width: 65.0,
        backgroundColor: RLZZColors.mainColor,
        text: StringZh.app_ok,
        fontColor: Colors.white,
        clickFun: () {
          Navigator.pop(context);
        },
      ),
    ));

    return new DialogPage(
      title: StringZh.badImage,
      mainWidget: new GridView.builder(
          itemCount: widget.images.length,
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

      /*new Container(
        height: widget.images.length == 0 ? 30.0 : 250.0,
        padding: new EdgeInsets.all(10.0),
        //color: RLZZColors.itemBodyColor,
        child: new ImageListWidget(
          widget.images,
          isShowRemove: true,
          width: 150.0,
        ),
      ),*/
      widthProportion: 0.7,
      heightProportion: 0.7,
      btnList: btnList,
    );
  }

  Widget getItem(int index) {
    Enclosure f = widget.images[index];

    return new GestureDetector(
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
              Fluttertoast.showToast(msg: StringZh.fileErrorTip, timeInSecForIos: 3);
              Navigator.pop(context);
            });
          }
        }
      },
      child: new Container(
        color: Colors.white,
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
