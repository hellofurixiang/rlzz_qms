import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:qms/common/config/Config.dart';

class DownloadsPathProvider {
  static const MethodChannel _channel =
      const MethodChannel(Config.methodChannel_downloads_path_provider);

  ///SD卡公有的目录 /storage/sdcard0
  static Future<Directory> get getExternalStoragePublicDirectory async {
    final String path = await _channel.invokeMethod('getExternalStoragePublicDirectory');
    if (path == null) {
      return null;
    }
    return Directory(path);
  }


  ///私有目录 /storage/emulated/0/Android/data/(包名)/files/
  static Future<Directory> get getExternalFilesDir async {
    final String path = await _channel.invokeMethod('getExternalFilesDir');
    if (path == null) {
      return null;
    }
    return Directory(path);
  }
}
