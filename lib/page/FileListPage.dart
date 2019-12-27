import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/utils/MethodChannelUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';

class FileListPage extends StatefulWidget {
  final List<Enclosure> enclosures;

  FileListPage(this.enclosures);

  @override
  State<StatefulWidget> createState() => FileListPageState();
}

class FileListPageState extends State<FileListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //double width = CommonUtil.getScreenWidth(context);
    //double height = CommonUtil.getScreenHeight(context);

    ///操作按钮
    List<Widget> btnList = new List();
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.mainColor,
      text: StringZh.app_close,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));

    return new DialogPage(
      title: '指标相关附件',
      mainWidget: new GridView.builder(
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
      btnList: btnList,
    );
  }

  Widget getItem(int index) {
    Enclosure f = widget.enclosures[index];

    return new GestureDetector(
      onTap: () async {
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
              WidgetUtil.showConfirmDialog(context, StringZh.downloadFinishTip,
                  () {
                openFile(f);
              }, confirmText: StringZh.yes, cancelText: StringZh.no);
            }
          }, (err) {
            Fluttertoast.showToast(msg: StringZh.fileErrorTip, timeInSecForIos: 3);
            Navigator.pop(context);
          });
        }
      },
      child: new Container(
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
