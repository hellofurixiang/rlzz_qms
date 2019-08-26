import 'package:qms/common/style/StringZh.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message) {
    String msg = '';
    switch (code) {
      case Code.NETWORK_ERROR:
        msg = StringZh.network_error;
        break;
      case 401:
        msg = StringZh.network_error_401;
        break;
      case 403:
        msg = StringZh.network_error_403;
        break;
      case 404:
        msg = StringZh.network_error_404;
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        msg = StringZh.network_error_timeout;
        break;
      default:
        msg = StringZh.network_error_unknown + '：' + message;
        break;
    }
    return msg;
  }
}
