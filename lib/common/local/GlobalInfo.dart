import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/QmsConfig.dart';

class GlobalInfo {
  // 工厂模式
  factory GlobalInfo() => _getInstance();

  static GlobalInfo get instance => _getInstance();
  static GlobalInfo _instance;

  GlobalInfo._internal() {
    // 初始化
  }

  static GlobalInfo _getInstance() {
    if (_instance == null) {
      _instance = new GlobalInfo._internal();
    }
    return _instance;
  }

  List<String> userPermissions;

  getUserPermissions() {
    return userPermissions ?? <String>[];
  }

  setUserPermissions(List<String> val) {
    userPermissions = val;
  }

  bool debug;

  isDebug() {
    return debug ?? false;
  }

  setDebug(bool isDebug) {
    debug = isDebug;
  }

  QmsConfig qmsConfig;

  getQmsConfig() {
    if (qmsConfig == null) {
      qmsConfig.qtyScale = Config.qtyScale;
    }
    return qmsConfig;
  }

  setQmsConfig(QmsConfig vo) {
    qmsConfig = vo;
  }

  String account;

  getAccount() {
    return account;
  }

  setAccount(String accountVal) {
    account = accountVal;
  }

  String loginDate;

  getLoginDate() {
    return loginDate;
  }

  setLoginDate(String val) {
    loginDate = val;
  }
}
