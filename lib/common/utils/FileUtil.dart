import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/modal/QmsConfig.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class FileUtil {
  static const MethodChannel perform =
      const MethodChannel(Config.methodChannel_file);

  static const String method_openFile = 'openFile';
  static const String method_openSharedFile = 'openSharedFile';

  ///调用原生系统代码打开文件
  static Future openFile(String path) async {
    //path = path.replaceAll('/data/user/0', '/data/data');

    String nameType = path.substring(path.lastIndexOf('.') + 1);
    final Map<String, dynamic> args = <String, dynamic>{
      'path': path,
      'nameType': nameType
    };
    String result = await perform.invokeMethod(method_openFile, args);
    if (!CommonUtil.isEmpty(result)) {
      Fluttertoast.showToast(
          msg: StringZh.openFileErrorTip + '：' + result, timeInSecForIos: 3);
    }
  }

  ///调用原生系统代码打开共享文件
  static Future openSharedFile(
      BuildContext context, String url,String fileName, String nameType) async {
    //path = path.replaceAll('/data/user/0', '/data/data');

    String enclosureDir = 'sharedFile';

    ///判断文件是否存在，存在则直接打开，不存在则下载完成之后打开
    bool bo = await CommonUtil.fileExists(fileName, enclosureDir: enclosureDir);
    if (bo) {
      String path = await CommonUtil.getFilePathByName(fileName,
          enclosureDir: enclosureDir);
      openFile(path);
    } else {
      QmsConfig qmsConfig = GlobalInfo.instance.getQmsConfig();
      //String username = "rlzz";
      //String password = "rlzz@123";
      //String url = qmsConfig.enclosureServiceUrl;
      if (CommonUtil.isEmpty(url)) {
        Fluttertoast.showToast(msg: StringZh.enclosureServiceUrlTip);
        return;
      }
      /*if (url.substring(url.length - 1) != '/') {
        url += '/';
      }*/

      WidgetUtil.showLoadingDialog(context, StringZh.downloading);

      String downloadPath =
          await CommonUtil.getDirectoryPath(enclosureDir: enclosureDir);

      ///共享访问用户名
      ///共享访问密码
      ///共享文件路径
      ///文件名
      ///下载文件夹
      ///文件类型
      Map<String, String> args = {
        'username': qmsConfig.config1,
        'password': qmsConfig.config2,
        //'url': 'smb://$url$fileName',
        'url': 'smb:$url',
        'fileName': fileName,
        'downloadPath': downloadPath,
        'nameType': nameType
      };
      String result = await perform.invokeMethod(method_openSharedFile, args);
      if (!CommonUtil.isEmpty(result)) {
        Fluttertoast.showToast(
            msg: StringZh.openFileErrorTip + '：' + result, timeInSecForIos: 3);
      }

      ///消除加载控件
      Navigator.pop(context);
    }
  }
}
