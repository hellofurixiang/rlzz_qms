import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/GeneralVo.dart';
import 'package:qms/common/modal/QmsConfig.dart';
import 'package:qms/common/utils/LogUtils.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/plugin/DownloadsPathProvider.dart';
import 'package:qms/common/utils/plugin/SimplePermissions.dart';

///通用逻辑
class CommonUtil {
  ///获取日期年月日
  static String getDateStr(String date) {
    if (date == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }

    return date.toString().substring(0, 10);
  }

  ///时间戳转换
  static String getDateFromTimeStamp(String timeStamp, {String dateFormat}) {
    if (null == timeStamp || '' == timeStamp) {
      return '';
    }
    try {
      int microsecondsSinceEpoch = int.tryParse(timeStamp);

      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(microsecondsSinceEpoch);

      var formatter = new DateFormat(dateFormat ?? 'yyyy-MM-dd');

      return formatter.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  ///获取日期年月日 时分秒
  static String getDateTimeStr(String date) {
    if (date == null) {
      return "";
    } else if (date.toString().length < 19) {
      return date.toString();
    }
    return date.toString().substring(0, 19);
  }

  ///日期比较，开始日期小于结束日期返回true
  static int dateCompare(String beginDate, String endDate) {
    try {
      return DateTime.parse(beginDate).compareTo(DateTime.parse(endDate));
    } catch (e) {}
    return -1;
  }

  ///返回两个日期相差的天数
  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      if (v < 0) v = -v;
      return v ~/ 86400000;
    }
  }

  static double getWindowWidth() {
    return window.physicalSize.width / window.devicePixelRatio;
  }

  ///获取屏幕宽度
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  ///获取屏幕高度
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///判断是否为大屏幕
  static bool checkIsLargeScreen(BuildContext context) {
    if (MediaQuery.of(context).size.width > Config.screenWidth) {
      return true;
    } else {
      return false;
    }
  }

  ///获取系统状态栏高度
  //static double sStaticBarHeight = 0.0;

  static double getStatusBarHeight(context) {
    return MediaQuery.of(context).padding.top;
    //await FlutterStatusbar.height / MediaQuery.of(context).devicePixelRatio;
  }

  ///获取查询筛选参数
  static Map<String, dynamic> getFilterParams(
      List<FilterModel> itemList, Map<String, dynamic> params) {
    /*params.toJson().addAll(requestParams);
    params = GeneralVo.fromJson(requestParams);*/

    itemList.forEach((item) {
      if (item.itemType == Config.filterItemTypeSingleSelect) {
        for (var map in item.selectList) {
          if (map.isSelect) {
            params[item.itemCode] = map.value;
          }
        }
      } else if (item.itemType == Config.filterItemTypeMultipleSelect) {
        String selects = '';
        for (var map in item.selectList) {
          if (map.isSelect) {
            selects += map.value + ',';
          }
        }
        params[item.itemCode] =
            selects == '' ? '' : selects.substring(0, selects.length - 1);
      } else if (item.itemType == Config.filterItemTypeDate) {
        item.itemCodes.forEach((val) {
          params[val] = item.returnVal[val];
        });
      } else if (item.itemType == Config.filterItemTypeRef) {
        params[item.itemCode] = item.initParam.arcCode;
        params[item.itemText] = item.initParam.arcName;
      } else if (item.itemType == Config.filterItemTypeInput) {
        params[item.itemCode] = item.returnVal[item.itemCode];
      }
    });

    return params;
  }

  ///获取筛选显示参数
  static void getShowFilterParams(
      List<FilterModel> itemList, Map<String, dynamic> params) {
    itemList.forEach((item) {
      if (item.itemType == Config.filterItemTypeSingleSelect) {
        item.selectList.forEach((map) {
          map.isSelect = map.value == params[item.itemCode] ? true : false;
        });
      } else if (item.itemType == Config.filterItemTypeMultipleSelect) {
        if (params[item.itemCode] == '') {
          item.selectList.forEach((map) {
            map.isSelect = false;
          });
        } else {
          List<String> selects = params[item.itemCode].split(',');
          for (var map in item.selectList) {
            map.isSelect = false;
            for (var str in selects) {
              if (map.value == str) {
                map.isSelect = true;
                break;
              }
            }
          }
        }
      } else if (item.itemType == Config.filterItemTypeDate) {
        item.itemCodes.forEach((val) {
          item.returnVal[val] = params[val];
        });
      } else if (item.itemType == Config.filterItemTypeRef) {
        item.initParam.arcCode = params[item.itemCode];
        item.initParam.arcName = params[item.itemText];
      } else if (item.itemType == Config.filterItemTypeInput) {
        item.returnVal[item.itemCode] = params[item.itemCode];
      }
    });
  }

  ///重置筛选参数
  static void resetFilterParams(List<FilterModel> itemList) {
    itemList.forEach((item) {
      if (item.itemType == Config.filterItemTypeSingleSelect ||
          item.itemType == Config.filterItemTypeMultipleSelect) {
        item.selectList.forEach((map) {
          map.isSelect = map.isDefault;
        });
      } else if (item.itemType == Config.filterItemTypeDate) {
        item.itemCodes.forEach((val) {
          item.returnVal[val] = '';
        });
      } else if (item.itemType == Config.filterItemTypeRef) {
        item.initParam.arcCode = '';
        item.initParam.arcName = '';
      } else if (item.itemType == Config.filterItemTypeInput) {
        item.returnVal[item.itemCode] = '';
      }
    });
  }

  ///停留时间
  static void stayTimeTodo(
      {int seconds: 3, @required Function fun, String msg}) {
    if (null != msg) {
      Fluttertoast.showToast(msg: msg, timeInSecForIos: 3);
    }
    var _duration = new Duration(seconds: 3);
    new Timer(_duration, fun);
  }

  ///获取消息文字
  static String getText(String msg, List<String> params) {
    for (int i = 0; i < params.length; ++i) {
      msg = msg.replaceAll("{" + i.toString() + "}", params[i]);
    }
    return msg;
  }

  ///为空判断
  static bool isEmpty(Object obj) {
    if (null == obj || '' == obj.toString().trim()) {
      return true;
    }
    return false;
  }

  ///不为空判断
  static bool isNotEmpty(Object obj) {
    return !isEmpty(obj);
  }

  ///退出登录清楚数据
  static clearUserInfo() async {
    await MySelfInfo.remove(Config.tokenKey);
    await MySelfInfo.remove(Config.passwordKey);
    await MySelfInfo.setKeepPwd(false);
  }

  ///判断是否为图片格式
  static bool isImage(String name) {
    if (name.isEmpty) {
      return false;
    }
    return name.endsWith("jpg") ||
        name.endsWith("jpeg") ||
        name.endsWith("bmp") ||
        name.endsWith("png") ||
        name.endsWith("gif");
  }

  ///获取文件后缀
  static String getFileSuffix(String name) {
    if (name.isEmpty) {
      return '';
    }
    return name.substring(name.lastIndexOf('.'));
  }

  ///网络二进制图片
  static Future<Uint8List> consolidateHttpClientResponseBytes(
      HttpClientResponse response) {
    // response.contentLength is not trustworthy when GZIP is involved
    // or other cases where an intermediate transformer has been applied
    // to the stream.
    final Completer<Uint8List> completer = Completer<Uint8List>.sync();
    final List<List<int>> chunks = <List<int>>[];
    int contentLength = 0;
    response.listen((List<int> chunk) {
      chunks.add(chunk);
      contentLength += chunk.length;
    }, onDone: () {
      final Uint8List bytes = Uint8List(contentLength);
      int offset = 0;
      for (List<int> chunk in chunks) {
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      completer.complete(bytes);
    }, onError: completer.completeError, cancelOnError: true);

    return completer.future;
  }

  ///请求数据转换成double数字类型
  static double dynamicToDouble(dynamic json) {
    String str = '0';
    if (isNotEmpty(json)) {
      str = json.toString();
    }
    return double.parse(str);
  }

  ///获取文件名称
  static String getFileName(Enclosure enclosure) {
    String fileSuffix = CommonUtil.getFileSuffix(enclosure.name);

    String fileName = enclosure.id + fileSuffix;

    if (Config.debug) {
      LogUtils.i('info:', '文件名称:$fileName');
    }
    return fileName;
  }

  ///获取文件路径
  static Future<String> getFilePath(Enclosure enclosure) async {
    await requestPermission();

    String localPath = (await DownloadsPathProvider.downloadsDirectory).path;

    String fileSuffix = CommonUtil.getFileSuffix(enclosure.name);
    String directoryPath = '$localPath/enclosure';

    await new Directory(directoryPath).create(recursive: true);

    String filePath = directoryPath + '/' + enclosure.id + fileSuffix;

    if (Config.debug) {
      LogUtils.i('info:', '文件路径:$filePath');
    }
    return filePath;
  }

  ///获取文件目录
  static Future<String> getDirectoryPath() async {
    await requestPermission();

    String localPath = (await DownloadsPathProvider.downloadsDirectory).path;

    String directoryPath = '$localPath/enclosure';

    await new Directory(directoryPath).create(recursive: true);

    if (Config.debug) {
      LogUtils.i('info:', '文件目录:$directoryPath');
    }
    return directoryPath;
  }

  ///获取服务主地址
  static Future<String> getServiceMainAddress() async {
    var protocol = await MySelfInfo.getProtocol();
    var ip = await MySelfInfo.getIP();
    var post = await MySelfInfo.getPost();
    return '$protocol://$ip:$post/';
  }

  ///调试状态做特殊处理
  static Future<String> getDebugAddress(String url, bool isDebug) async {
    String mainUrl = await CommonUtil.getServiceMainAddress();
    isDebug = isDebug ?? false;
    if (!isDebug) {
      return mainUrl + url;
    }

    if (url.contains(Config.qmsApiUrl)) {
      return mainUrl + url.replaceAll(Config.qmsApiUrl, 'api/qms/app');
    } else {
      return Config.debugBosIp + url;
    }
  }

  ///获取文件图标
  static String selectIcon(String fileName) {
    try {
      String iconImg;
      String str = extension(fileName);
      switch (str) {
        case '.ppt':
        case '.pptx':
          iconImg = 'assets/images/ppt.png';
          break;
        case '.doc':
        case '.docx':
          iconImg = 'assets/images/word.png';
          break;
        case '.xls':
        case '.xlsx':
          iconImg = 'assets/images/excel.png';
          break;
        case '.jpg':
        case '.jpeg':
        case '.png':
          iconImg = 'assets/images/image.png';
          break;
        case '.txt':
          iconImg = 'assets/images/txt.png';
          break;
        case '.mp3':
          iconImg = 'assets/images/mp3.png';
          break;
        case '.mp4':
          iconImg = 'assets/images/video.png';
          break;
        case '.rar':
        case '.zip':
          iconImg = 'assets/images/zip.png';
          break;
        case '.psd':
          iconImg = 'assets/images/psd.png';
          break;
        case '.pdf':
          iconImg = 'assets/images/pdf.png';
          break;
        default:
          iconImg = 'assets/images/file.png';
          break;
      }
      return iconImg;
    } catch (e) {
      print(e);
      return 'assets/images/unknown.png';
    }
  }

  // ignore: missing_return
  static String getFileSize(int fileSize) {
    if (fileSize < 1024) {
      // b
      return '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      // kb
      return '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      // mb
      return '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }
  }

  ///获取正则表达式
  static getRegExp(String type) {
    return RegExp(
        r'^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$');
  }

  ///字符串转double
  static double stringToDouble(String old) {
    if (isEmpty(old)) {
      return null;
    }

    double newObj = double.tryParse(old);

    if (isEmpty(newObj)) {
      return null;
    } else {
      return newObj;
    }
  }

  ///获取写入、读取权限
  static requestPermission() async {
    PermissionStatus wStatus = await SimplePermissions.getPermissionStatus(
        Permission.WriteExternalStorage);

    if (wStatus != PermissionStatus.authorized) {
      await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
    }

    PermissionStatus rStatus = await SimplePermissions.getPermissionStatus(
        Permission.ReadExternalStorage);

    if (rStatus != PermissionStatus.authorized) {
      await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    }
  }

  static double getDoubleValue(String oldVal) {
    double value = 0;
    if ('' != oldVal.trim()) {
      value = double.parse(oldVal.trim());
    }
    QmsConfig qmsConfig = GlobalInfo.instance.getQmsConfig();
    return double.parse(formatNum(value, qmsConfig.qtyScale));
  }

  static String getDoubleScale(double oldVal) {
    QmsConfig qmsConfig = GlobalInfo.instance.getQmsConfig();

    return formatNum(oldVal == null ? 0 : oldVal, qmsConfig.qtyScale);
  }

  static String formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1);
    } else {
      num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1);
    }
  }

  static int getIntValue(String oldVal) {
    if ('' == oldVal.trim()) {
      return 0;
    }

    return int.parse(oldVal.trim());
  }

  static String getVal(var val) {
    return val == null ? '' : val.toString();
  }

  ///获取用户权限列表
  static List<String> getUserPermissions() {
    return GlobalInfo.instance.getUserPermissions();
  }

  ///检查是否有对应权限
  static bool checkUserPermissions(String permissions, String permissionsText) {
    if (isEmpty(permissions)) {
      return true;
    }
    List<String> list = GlobalInfo.instance.getUserPermissions();

    if (Config.debug) {
      LogUtils.i('info:', '权限 $permissionsText:$permissions');
    }

    if (GlobalInfo.instance.isDebug()) {
      return true;
    }
    if (list.length == 0) {
      return true;
    }
    if (list.contains(permissions)) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: getText(StringZh.tip_permissions_error, [permissionsText]),
          timeInSecForIos: 3);
      return false;
    }
  }
}
