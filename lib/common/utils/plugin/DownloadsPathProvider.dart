import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:qms/common/config/Config.dart';

class DownloadsPathProvider {
  static const MethodChannel _channel =
      const MethodChannel(Config.methodChannel_downloads_path_provider);

  static Future<Directory> get downloadsDirectory async {
    final String path = await _channel.invokeMethod('getDownloadsDirectory');
    if (path == null) {
      return null;
    }
    return Directory(path);
  }
}
