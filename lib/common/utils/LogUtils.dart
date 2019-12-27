import 'package:qms/common/utils/MethodChannelUtil.dart';

class LogUtils {
  static void v(String tag, String message) {
    log('logV', tag, message);
  }

  static void d(String tag, String message) {
    log('logD', tag, message);
  }

  static void i(String tag, String message) {
    log('logI', tag, message);
  }

  static void w(String tag, String message) {
    log('logW', tag, message);
  }

  static void e(String tag, String message) {
    log('logE', tag, message);
  }

  static void log(String logType, String tag, String message) {
    MethodChannelUtil.perform.invokeMethod(
        'logPrint', {'logType': logType, 'tag': tag, 'msg': message});
  }
}
