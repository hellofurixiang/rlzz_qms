import 'dart:convert';

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

  List<String> userResources;

  getUserResources() {
    return userResources ?? <String>[];
  }

  setUserResources(List<String> val) {
    userResources = val;
  }
}
