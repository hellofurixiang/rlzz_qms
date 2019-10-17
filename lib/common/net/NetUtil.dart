import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/net/LogUtils.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/plugin/Connectivity.dart';
import 'package:qms/common/utils/DeviceUtil.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/net/Code.dart';

///网络请求
class NetUtil {
  static String logTag = 'NetUtil';

  ///get请求
  static void get(String url, BuildContext context,
      {Map<String, Object> params,
      ContentType contentType,
      ResponseType responseType,
      Function successCallBack,
      Function errorCallBack}) async {
    request(url, context, Config.method_get,
        params: params,
        contentType: contentType,
        responseType: responseType,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///post请求
  static void post(String url, BuildContext context,
      {Map<String, Object> params,
      ContentType contentType,
      ResponseType responseType,
      Function successCallBack,
      Function errorCallBack}) async {
    request(url, context, Config.method_post,
        params: params,
        contentType: contentType,
        responseType: responseType,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///请求头初始化
  static Map<String, String> headers = {
    'x-user-agent': 'mobile-web-app',
    'Source': 'Android',
    'Accept': 'application/json'
  };

  ///获取请求头
  static Future<Map<String, String>> getHeaders() async {
    var brandModel = await DeviceUtil.getBrandModel();
    var identity = await DeviceUtil.getIdentity();
    var token = await MySelfInfo.getToken();
    var sob = await MySelfInfo.getSob();

    headers['Device'] = brandModel ?? '';
    headers['DeviceId'] = identity ?? '';
    headers['x-user-token'] = token ?? '';
    headers['x-request-datasource'] = sob;

    return headers;
  }

  ///Content-Type
  ///text/html：HTML格式
  ///text/pain：纯文本格式
  ///image/jpeg：jpg图片格式
  ///application/json：JSON数据格式
  ///application/octet-stream：二进制流数据（如常见的文件下载）
  ///application/x-www-form-urlencoded：form表单encType属性的默认格式，表单数据将以key/value的形式发送到服务端
  ///multipart/form-data：表单上传文件的格式

  ///请求配置
  static getBaseOptions(
      {ContentType contentType,
      ResponseType responseType,
      String method}) async {
    await getHeaders();
    if (Config.debug) {
      LogUtils.i(logTag, '<net> headers:');
      headers.forEach((key, value) => LogUtils.i(logTag, '$key:$value'));
      LogUtils.i(logTag, '<net> headers end');
    }

    Options options = new Options();

    ///网络文件的类型和网页的编码
    if (contentType != null) {
      options.contentType = contentType;
    }

    ///接收格式
    if (responseType != null) {
      options.responseType = responseType;
    }

    ///请求头
    options.headers.addAll(headers);

    ///超时时间
    options.connectTimeout = Config.connectTimeout;
    options.receiveTimeout = Config.receiveTimeout;

    options.method = method ?? Config.method_get;

    return options;
  }

  ///请求配置
  static getOptions(
      {ContentType contentType,
      ResponseType responseType,
      String method}) async {
    await getHeaders();
    if (Config.debug) {
      LogUtils.i(logTag, '<net> headers:');
      headers.forEach((key, value) => LogUtils.i(logTag, '$key:$value'));
      LogUtils.i(logTag, '<net> headers end');
    }

    Options options = new Options();

    ///网络文件的类型和网页的编码
    if (contentType != null) {
      options.contentType = contentType;
    }

    ///接收格式
    if (responseType != null) {
      options.responseType = responseType;
    }

    ///请求头
    options.headers.addAll(headers);

    ///超时时间
    options.connectTimeout = Config.connectTimeout;
    options.receiveTimeout = Config.receiveTimeout;

    options.method = method ?? Config.method_get;

    return options;
  }

  ///具体的还是要看返回数据的基本结构
  ///公共代码部分
  static void request(String url, BuildContext context, String method,
      {Map<String, Object> params,
      ContentType contentType,
      ResponseType responseType,
      Function successCallBack,
      Function errorCallBack}) async {
    ///网络连接判断
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: '网络连接异常，请检查网络', timeInSecForIos: 3);
      return;
    }

    if (Config.debug) {
      if (params != null && params.isNotEmpty) {
        LogUtils.i(logTag, '<net> params :' + params.toString());
      } else {
        LogUtils.i(logTag, '<net> no params');
      }
    }

    Options options = await getOptions(
        contentType: contentType, responseType: responseType, method: method);

    String requestUrl;
    if (!url.startsWith(new RegExp(r"http?:"))) {
      bool isDebug = await MySelfInfo.isDebug();
      if (Config.debug) {
        LogUtils.i(logTag, '<net> 测试状态  $isDebug');
      }

      ///调试状态则修改主地址
      requestUrl = await CommonUtil.getDebugAddress(url, isDebug);
    } else {
      requestUrl = url;
    }

    if (!requestUrl.startsWith(new RegExp(r"http?:"))) {
      handError('服务地址异常：$requestUrl', errorCallBack: errorCallBack);
      return;
    }
    if (Config.debug) {
      LogUtils.i(logTag, '<net> 请求地址  $requestUrl');
    }

    try {
      Response response =
          await Dio().request(requestUrl, data: params, options: options);

      int statusCode = response.statusCode;

      ///处理错误部分
      if (statusCode != Code.SUCCESS) {
        handError(
            Code.errorHandleFunction(
                statusCode, '网络请求错误,状态码:' + statusCode.toString()),
            errorCallBack: errorCallBack);
        return;
      }
      if (Config.debug) {
        LogUtils.i(logTag, '<net> response data:');
        LogUtils.i(logTag, response.data.toString());
        LogUtils.i(logTag, '<net> response data end');
      }

      successCallBack(response.data);
    } on DioError catch (e) {
      var error = '';
      if (e.response != null) {
        if (e.response.data != null) {
          try {
            error = json.decode(e.response.data)['message'];
          } catch (ex) {
            error = e.response.data['message'];
          }
        }
      }

      if (error.contains('token')) {
        await CommonUtil.clearUserInfo();

        ///使用情况：例如 当用户点击了退出登录时，
        ///我们需要进入某一个页面（比如点退出登录后进入了登录页），
        ///这个时候用户点击返回时不应该能进入任何一个页面，这种情况就可以使用。
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
      catchError(e, context, errorCallBack: errorCallBack);
    }
  }

  static void catchError(e, BuildContext context, {Function errorCallBack}) {
    if (Config.debug) {
      LogUtils.e(logTag, e.toString());
    }
    var error = '';
    var statusCode = 666;
    try {
      if (e.response != null) {
        if (e.response.data != null) {
          try {
            error = json.decode(e.response.data)['message'];
          } catch (ex) {
            error = e.response.data['message'];
          }
        }
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        statusCode = Code.NETWORK_TIMEOUT;
      } else if (e.type == DioErrorType.DEFAULT) {
        statusCode = Code.NETWORK_ERROR;
      }
      if (e.type == DioErrorType.RESPONSE) {
        //statusCode = 404;
        if ('' == error) {
          error = '请求服务器异常';
        }
      }
    } catch (ex) {
      error = e.toString();
    }
    handError(Code.errorHandleFunction(statusCode, error),
        errorCallBack: errorCallBack);
  }

  ///处理异常
  static void handError(String errorMsg, {Function errorCallBack}) {
    if (Config.debug) {
      LogUtils.e(logTag, '<net> errorMsg :' + errorMsg);
    }
    if (errorCallBack != null) {
      errorCallBack(errorMsg);
    } else {
      Fluttertoast.showToast(msg: errorMsg, timeInSecForIos: 3);
    }
  }
}
