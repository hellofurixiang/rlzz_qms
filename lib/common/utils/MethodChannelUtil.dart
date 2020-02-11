import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';

class MethodChannelUtil {
  static const perform = const MethodChannel("flutter_android_channel");

  ///调用原生系统代码打开文件
  static Future openFile(String path) async {
    //path = path.replaceAll('/data/user/0', '/data/data');

    String nameType = path.substring(path.lastIndexOf('.') + 1);
    final Map<String, dynamic> args = <String, dynamic>{
      'path': path,
      'nameType': nameType
    };
    String result = await perform.invokeMethod('openFile', args);
    if(!CommonUtil.isEmpty(result)) {
      Fluttertoast.showToast(
          msg: StringZh.openFileErrorTip + '：' + result, timeInSecForIos: 3);
    }
  }

  ///调用原生系统代码打开共享文件
  static Future openSharedFile(String path) async {
    //path = path.replaceAll('/data/user/0', '/data/data');

    String nameType = path.substring(path.lastIndexOf('.') + 1);
    final Map<String, dynamic> args = <String, dynamic>{
      'path': path,
      'nameType': nameType
    };
    String result = await perform.invokeMethod('openSharedFile', args);
    if(!CommonUtil.isEmpty(result)) {
      Fluttertoast.showToast(
          msg: StringZh.openFileErrorTip + '：' + result, timeInSecForIos: 3);
    }
  }
}
