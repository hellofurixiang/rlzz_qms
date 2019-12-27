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
    return debug;
  }

  setDebug(bool isDebug) {
    debug = isDebug;
  }

  int qtyScale;

  getQtyScale() {
    return qtyScale;
  }

  setQtyScale(int num) {
    qtyScale = num;
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
