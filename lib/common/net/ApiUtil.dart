import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/QmsConfig.dart';
import 'package:qms/common/net/Code.dart';
import 'package:qms/common/utils/LogUtils.dart';
import 'package:qms/common/net/NetUtil.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///方法
class ApiUtil {
  static String logTag = 'ApiUtil';

  ///测试服务器网络是否正常
  static void testNetwork(BuildContext context, String protocol, String ip,
      String post, Function successCallBack, Function errorCallBack) {
    String url = '$protocol://$ip:$post/info';

    NetUtil.get(url, context,
        successCallBack: successCallBack, errorCallBack: errorCallBack);
  }

  ///登录
  static void login(BuildContext context, Map<String, String> params,
      Function successCallBack, Function errorCallBack) {
    String url = 'login';

    NetUtil.post(url, context,
        params: params,
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
        responseType: ResponseType.PLAIN,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///退出
  static void logout(BuildContext context, Function successCallBack) {
    String url = 'logout';

    NetUtil.get(url, context, successCallBack: successCallBack);
  }

  ///获取账套
  static void getSobs(BuildContext context, Function successCallBack) {
    String url = 'ledgers'; //'''sobs';

    NetUtil.get(url, context, successCallBack: successCallBack);
  }

  ///获取用户系统配置
  static void getUserInfoAndConfig(BuildContext context, String account,
      Function successCallBack, Function errorCallBack) async {
    ///调试状态
    bool isDebug = GlobalInfo.instance.isDebug();

    String url = await CommonUtil.getServiceMainAddress();

    ///获取用户信息
    /*String url1 =
        (isDebug ? Config.debugBosIp : url + Config.bossApiUrl + '/') +
            'api/user/get/$account';*/

    ///系统配置信息
    String url2 =
        url + (isDebug ? 'api/qms/app' : Config.qmsApiUrl) + '/getConfig';

    ///获取用户权限
    String url3 = Config.debugBosIp +
        Config.bossApiUrl +
        '/api/user/resources?user=$account';

    Options options = await NetUtil.getBaseOptions();

    Dio dio = new Dio(options);

    try {
      if (Config.debug) {
        //LogUtils.i(logTag, '<net> 请求地址url1：$url1');
        LogUtils.i(logTag, '<net> 请求地址url2：$url2');
        LogUtils.i(logTag, '<net> 请求地址url3：$url3');
      }
      List<Response> responses;

      responses = await Future.wait([
        dio.get(url2),
        dio.post(url3, data: {'user': account})
      ]);

      for (int i = 0; i < responses.length; i++) {
        Response response = responses[i];

        int statusCode = response.statusCode;

        ///处理错误部分
        if (statusCode != Code.SUCCESS) {
          NetUtil.handError('<net> 网络请求错误,状态码:' + statusCode.toString(),
              errorCallBack: errorCallBack);
          return;
        }
        if (Config.debug) {
          LogUtils.i(logTag, '<net> response data:');
          LogUtils.i(logTag, json.encode(response.data));
          LogUtils.i(logTag, '<net> response data end');
        }
        switch (i) {
          case 0:
            /* ///获取用户信息
            MySelfInfo.setUserInfo(json.encode(response.data));
            break;

          case 1:*/

            ///精度
            //await MySelfInfo.setQtyScale(response.data);
            GlobalInfo.instance.setQmsConfig(QmsConfig.fromJson(response.data));
            break;
          case 1:
            //GlobalInfo globalInfo = new GlobalInfo();

            ///获取用户权限
            GlobalInfo.instance
                .setUserPermissions(List<String>.from(response.data));
            break;
          default:
            break;
        }
      }
      successCallBack();
    } catch (e) {
      NetUtil.catchError(e, context, errorCallBack: errorCallBack);
    }
  }

  ///修改密码
  static void changePassword(
      BuildContext context,
      String oldPassword,
      String newPassword,
      Function successCallBack,
      Function errorCallBack) async {
    String url = Config.bossApiUrl + '/api/user/password/change';

    Map<String, String> params = {
      'account': GlobalInfo.instance.getAccount(),
      'oldPwd': oldPassword,
      'newPwd': newPassword
    };

    NetUtil.post(url, context,
        params: params,
        contentType: new ContentType('application', 'x-www-form-urlencoded',
            charset: 'utf-8'),
        responseType: ResponseType.PLAIN,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取图片字节流
  static void getImageListBytes(
      BuildContext context,
      List<Enclosure> enclosures,
      Function successCallBack,
      Function errorCallBack) async {
    Options options =
        await NetUtil.getBaseOptions(responseType: ResponseType.STREAM);

    Dio dio = new Dio(options);

    ///调试状态
    bool isDebug = GlobalInfo.instance.isDebug();

    ///服务器地址
    String requestUrl = (isDebug
            ? Config.debugBosIp
            : await CommonUtil.getServiceMainAddress()) +
        Config.bossApiUrl +
        '/api/attachment/byte/';

    List<Future<Response<dynamic>>> requests = new List();

    for (int i = 0; i < enclosures.length; i++) {
      var f = enclosures[i];
      requests.add(dio.get(requestUrl + f.id));
      if (Config.debug) {
        LogUtils.i(logTag, '<net>请求地址:' + requestUrl + f.id);
      }
    }

    List<Future<Uint8List>> uint8Lists = [];

    try {
      List<Response> responses = await Future.wait(requests);
      for (int i = 0; i < responses.length; i++) {
        Response response = responses[i];

        int statusCode = response.statusCode;

        ///处理错误部分
        if (statusCode != Code.SUCCESS) {
          errorCallBack();
          //NetUtil.handError('<net> 网络请求错误,状态码:' + statusCode.toString());
          return;
        }

        Future<Uint8List> uint8list =
            CommonUtil.consolidateHttpClientResponseBytes(response.data);
        //enclosures[i].uint8list = uint8list;
        uint8Lists.add(uint8list);
      }
      successCallBack(uint8Lists);
    } catch (e) {
      NetUtil.catchError(e, context);
      errorCallBack();
    }
  }

  ///获取图片字节流
  static void getImageBytes(BuildContext context, Enclosure enclosure,
      Function successCallBack, Function errorCallBack) async {
    Options options =
        await NetUtil.getBaseOptions(responseType: ResponseType.STREAM);

    Dio dio = new Dio(options);

    ///调试状态
    bool isDebug = GlobalInfo.instance.isDebug();

    ///服务器地址
    String requestUrl = (isDebug
            ? Config.debugBosIp
            : await CommonUtil.getServiceMainAddress()) +
        Config.bossApiUrl +
        '/api/attachment/byte/${enclosure.id}';

    if (Config.debug) {
      LogUtils.i(logTag, '<net>请求地址:' + requestUrl);
    }

    try {
      Response response = await dio.get(requestUrl);

      int statusCode = response.statusCode;

      ///处理错误部分
      if (statusCode != Code.SUCCESS) {
        errorCallBack();
        //NetUtil.handError('<net> 网络请求错误,状态码:' + statusCode.toString());
        return;
      }

      Future<Uint8List> uint8list =
          CommonUtil.consolidateHttpClientResponseBytes(response.data);
      enclosure.thumbnail = uint8list;

      successCallBack();
    } catch (e) {
      NetUtil.catchError(e, context);
      errorCallBack();
    }
  }

  ///获取图片字节流
  static void getImageListThumbnail(
      BuildContext context,
      List<Enclosure> enclosures,
      Function successCallBack,
      Function errorCallBack) async {
    Options options =
        await NetUtil.getBaseOptions(responseType: ResponseType.STREAM);

    Dio dio = new Dio(options);

    ///调试状态
    bool isDebug = GlobalInfo.instance.isDebug();

    ///服务器地址
    String requestUrl = (isDebug
            ? Config.debugBosIp
            : await CommonUtil.getServiceMainAddress()) +
        Config.bossApiUrl +
        '/api/attachment/image-thumbnail/';

    List<Future<Response<dynamic>>> requests = new List();

    for (int i = 0; i < enclosures.length; i++) {
      var f = enclosures[i];
      requests.add(dio.get(requestUrl + f.id));
      if (Config.debug) {
        LogUtils.i(logTag, '<net>请求地址:' + requestUrl + f.id);
      }
    }

    List<Future<Uint8List>> uint8Lists = [];

    try {
      List<Response> responses = await Future.wait(requests);
      for (int i = 0; i < responses.length; i++) {
        Response response = responses[i];

        int statusCode = response.statusCode;

        ///处理错误部分
        if (statusCode != Code.SUCCESS) {
          errorCallBack();
          //NetUtil.handError('<net> 网络请求错误,状态码:' + statusCode.toString());
          return;
        }

        Future<Uint8List> uint8list =
            CommonUtil.consolidateHttpClientResponseBytes(response.data);
        //enclosures[i].uint8list = uint8list;
        uint8Lists.add(uint8list);
      }
      successCallBack(uint8Lists);
    } catch (e) {
      NetUtil.catchError(e, context);
      errorCallBack();
    }
  }

  ///获取图片字节流
  static void downloadFileList(BuildContext context, List<Enclosure> enclosures,
      Function successCallBack, Function errorCallBack) async {
    Options options = await NetUtil.getBaseOptions();

    Dio dio = new Dio(options);

    ///调试状态
    bool isDebug = GlobalInfo.instance.isDebug();

    ///服务器地址
    String requestUrl = (isDebug
            ? Config.debugBosIp
            : await CommonUtil.getServiceMainAddress()) +
        Config.bossApiUrl +
        '/api/attachment/file/';

    List<Future<Response<dynamic>>> requests = new List();

    for (int i = 0; i < enclosures.length; i++) {
      var f = enclosures[i];
      requests.add(dio.get(requestUrl + f.id));
      if (Config.debug) {
        LogUtils.i(logTag, '<net>请求地址:' + requestUrl + f.id);
      }
    }

    try {
      List<Response> responses = await Future.wait(requests);
      for (int i = 0; i < responses.length; i++) {
        Response response = responses[i];

        int statusCode = response.statusCode;

        ///处理错误部分
        if (statusCode != Code.SUCCESS) {
          errorCallBack('网络请求错误,状态码:' + statusCode.toString());
          return;
        }

        if (CommonUtil.isNotEmpty(response.data)) {
          String filePath = await CommonUtil.getFilePath(enclosures[i]);

          File file = File(filePath);

          String body = response.data['body'];

          Uint8List bytes = Base64Codec().decode(body);

          await file.writeAsBytes(bytes);

          enclosures[i].localFile = file;
          enclosures[i].path = filePath;
        }
      }
      successCallBack();
    } catch (e) {
      errorCallBack();
      //NetUtil.catchError(e, context);
    }
  }

  ///下载文件
  static void downloadFile(BuildContext context, Enclosure enclosure,
      Function successCallBack, Function errorCallBack) async {
    String url = Config.bossApiUrl + '/api/attachment/file/' + enclosure.id;

    String filePath = await CommonUtil.getFilePath(enclosure);

    File file = File(filePath);

    NetUtil.get(url, context, successCallBack: (res) async {
      if (CommonUtil.isEmpty(res)) {
        Fluttertoast.showToast(msg: '文件不存在或已被删除', timeInSecForIos: 3);
        successCallBack(false);
        return;
      }
      String body = res['body'];

      Uint8List bytes = Base64Codec().decode(body);

      await file.writeAsBytes(bytes);

      enclosure.localFile = file;
      enclosure.path = filePath;

      successCallBack(true);
    }, errorCallBack: errorCallBack);
  }

  ///上传文件
  static void uploadImages(BuildContext context, Enclosure enclosure,
      Function successCallBack, Function errorCallBack) async {
    try {
      Options options = await NetUtil.getBaseOptions();
      options.headers.addAll({'x-access-token': 'android-upload'});
      Dio dio = new Dio(options);

      ///调试状态
      bool isDebug = GlobalInfo.instance.isDebug();

      ///服务器地址
      String requestUrl = (isDebug
              ? Config.debugBosIp
              : await CommonUtil.getServiceMainAddress()) +
          Config.bossApiUrl +
          '/api/attachment/upload';

      List<Future<Response<dynamic>>> requests = new List();

      List<int> bytes = await enclosure.localFile.readAsBytes();
      String path = enclosure.localFile.path;

      String fileName = path.substring(path.lastIndexOf('/') + 1);

      String url = requestUrl + '?name=' + fileName + '&remark=android';
      requests.add(dio.post(url, data: bytes));

      if (Config.debug) {
        LogUtils.i(logTag, '<net>请求地址:' + url);
      }

      Response response = await dio.post(url, data: bytes);

      int statusCode = response.statusCode;

      ///处理错误部分
      if (statusCode != Code.SUCCESS) {
        NetUtil.handError('网络请求错误,状态码:' + statusCode.toString());
        return;
      }

      var e = response.data;
      enclosure.id = e["id"].toString();
      enclosure.name = e["name"];
      enclosure.size = e["size"].toString();
      enclosure.type = e["type"];
      enclosure.uploader = e["uploader"];
      enclosure.remark = e["remark"];

      if (Config.debug) {
        LogUtils.i('NetUtil', '<net> response data:');
        LogUtils.i('NetUtil', response.data.toString());
        LogUtils.i('NetUtil', '<net> response data end');
      }

      successCallBack();
    } catch (e) {
      NetUtil.catchError(e, context);
      errorCallBack();
    }
  }

  static void uploadImageList(BuildContext context, List<Enclosure> enclosures,
      Function successCallBack, Function errorCallBack) async {
    try {
      Options options = await NetUtil.getBaseOptions();
      options.headers.addAll({'x-access-token': 'android-upload'});
      Dio dio = new Dio(options);

      ///调试状态
      bool isDebug = GlobalInfo.instance.isDebug();

      ///服务器地址
      String requestUrl = (isDebug
              ? Config.debugBosIp
              : await CommonUtil.getServiceMainAddress()) +
          Config.bossApiUrl +
          '/api/attachment/upload';

      if (Config.debug) {
        LogUtils.i(logTag, '<net>请求地址:' + requestUrl);
      }

      List<Future<Response<dynamic>>> requests = new List();

      int num = 0;
      for (int i = 0; i < enclosures.length; i++) {
        Enclosure enclosure = enclosures[i];
        if (CommonUtil.isNotEmpty(enclosure.id)) {
          continue;
        }

        enclosure.index = num;
        List<int> bytes = await enclosure.localFile.readAsBytes();
        String path = enclosure.localFile.path;

        String fileName =
            path.substring(enclosure.localFile.parent.path.length + 1);

        String url = requestUrl + '?name=' + fileName + '&remark=android';
        requests.add(dio.post(url, data: bytes));

        num++;
      }

      List<Response> responses = await Future.wait(requests);

      for (int i = 0; i < responses.length; i++) {
        Response response = responses[i];

        int statusCode = response.statusCode;

        ///处理错误部分
        if (statusCode != Code.SUCCESS) {
          NetUtil.handError('<net> 网络请求错误,状态码:' + statusCode.toString(),
              errorCallBack: errorCallBack);
          return;
        }
        if (Config.debug) {
          LogUtils.i(logTag, '<net> response data:');
          LogUtils.i(logTag, json.encode(response.data));
          LogUtils.i(logTag, '<net> response data end');
        }

        var e = response.data;
        /*enclosure.id = e["id"].toString();
        enclosure.name = e["name"];
        enclosure.size = e["size"].toString();
        enclosure.type = e["type"];
        enclosure.uploader = e["uploader"];
        enclosure.remark = e["remark"];*/

        enclosures.forEach((f) {
          if (f.index == i) {
            f.id = e["id"].toString();
            f.name = e["name"];
            f.size = e["size"].toString();
            f.type = e["type"];
            f.uploader = e["uploader"];
            f.remark = e["remark"];
          }
        });
      }

      successCallBack();
    } catch (e) {
      NetUtil.catchError(e, context);
      errorCallBack();
    }
  }
}
