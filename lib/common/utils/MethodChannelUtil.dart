import 'package:flutter/services.dart';

class MethodChannelUtil {
  static const perform = const MethodChannel("flutter_android_channel");

  ///调用原生系统代码打开文件
  static void openFile(String path) {
    //path = path.replaceAll('/data/user/0', '/data/data');

    String nameType = path.substring(path.lastIndexOf('.') + 1);
    final Map<String, dynamic> args = <String, dynamic>{
      'path': path,
      'nameType': nameType
    };
    perform.invokeMethod('openFile', args);
  }
}
