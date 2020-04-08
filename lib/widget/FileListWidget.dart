import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/FileUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class FileListWidget extends StatefulWidget {
  final List<Enclosure> enclosures;

  FileListWidget(this.enclosures);

  @override
  State<StatefulWidget> createState() => FileListWidgetState();
}

class FileListWidgetState extends State<FileListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enclosures.length == 0) {
      return Container();
    } else {
      return new GridView.builder(
          itemCount: widget.enclosures.length,
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(

              ///SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item
              ///SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item

              //单个子Widget的水平最大宽度
              maxCrossAxisExtent: 300,
              //水平单个子Widget之间间距
              mainAxisSpacing: 10.0,
              //垂直单个子Widget之间间距
              crossAxisSpacing: 10.0,

              //子组件宽高长度比例
              childAspectRatio: 6),
          itemBuilder: (BuildContext context, int index) {
            return getItem(index);
          });
    }
  }

  Widget getItem(int index) {
    Enclosure f = widget.enclosures[index];

    return new GestureDetector(
      onTap: () async {
        ///获取文件路径
        String filePath = await CommonUtil.getFilePath(f);

        print(filePath);
        File file = File(filePath);

        ///判断文件是否已经存在，存在直接打开
        bool bo = await file.exists();
        if (bo) {
          f.path = filePath;
          openFile(f);
        } else {
          ///下载文件，并打开
          WidgetUtil.showLoadingDialog(context, StringZh.imageLoading);

          ///下载文件，并打开
          ApiUtil.downloadFile(context, f, () {
            Navigator.pop(context);
            openFile(f);
          }, (err) {
            Fluttertoast.showToast(msg: StringZh.fileErrorTip, timeInSecForIos: 3);
            Navigator.pop(context);
          });
        }
      },
      child: new ListTile(
        leading: Image.asset(
          CommonUtil.selectIcon(f.name),
          height: 40.0,
          width: 40.0,
        ),
        title: new Text(f.name),
        subtitle: Text(
          CommonUtil.getFileSize(int.parse(f.size)),
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );
  }

  void openFile(Enclosure f) {
    FileUtil.openFile(f.path);
  }
}
