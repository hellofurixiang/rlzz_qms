import 'dart:async';

import 'package:qms/common/utils/plugin/DeviceInfo.dart';

///设备服务类
class DeviceUtil {
  static DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

  ///获取手机品牌 + 型号
  static Future<String> getBrandModel() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String board = androidInfo.board;
    String model = androidInfo.model;

    return "$board($model)";
  }

  ///获取全局唯一标识
  static Future<String> getIdentity() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo.id.toString();
  }
}
