import 'dart:async';
import 'dart:convert';
import 'package:qms/common/local/LocalStorage.dart';
import 'package:qms/common/config/Config.dart';

import 'package:qms/common/modal/User.dart';

class MySelfInfo {
  static removeSetting() async {
    await LocalStorage.remove(Config.protocolKey);
    await LocalStorage.remove(Config.ipKey);
    await LocalStorage.remove(Config.postKey);
    await LocalStorage.remove(Config.catalogKey);
  }

  static remove(String key) async {
    await LocalStorage.remove(key);
  }

  static Future<String> getProtocol() async {
    return await LocalStorage.get(Config.protocolKey);
  }

  static setProtocol(String protocol) async {
    await LocalStorage.saveString(Config.protocolKey, protocol);
  }

  static Future<String> getIP() async {
    return await LocalStorage.get(Config.ipKey);
  }

  static setIP(String ip) async {
    await LocalStorage.saveString(Config.ipKey, ip);
  }

  static Future<String> getPost() async {
    return await LocalStorage.get(Config.postKey);
  }

  static setPost(String post) async {
    await LocalStorage.saveString(Config.postKey, post);
  }

  static Future<String> getCatalog() async {
    return await LocalStorage.get(Config.catalogKey);
  }

  static setCatalog(String catalog) async {
    await LocalStorage.saveString(Config.catalogKey, catalog);
  }

  static Future<String> getSob() async {
    return await LocalStorage.get(Config.sobKey);
  }

  static setSob(String sob) async {
    await LocalStorage.saveString(Config.sobKey, sob);
  }

  static Future<String> getToken() async {
    return await LocalStorage.get(Config.tokenKey);
  }

  static setToken(String token) async {
    await LocalStorage.saveString(Config.tokenKey, token);
  }

  static removeToken() async {
    await LocalStorage.remove(Config.tokenKey);
  }

  static Future<String> getLoginDate() async {
    return await LocalStorage.get(Config.loginDateKey);
  }

  static setLoginDate(String loginDate) async {
    await LocalStorage.saveString(Config.loginDateKey, loginDate);
  }

  static Future<int> getQtyScale() async {
    return await LocalStorage.get(Config.qtyScaleKey);
  }

  static setQtyScale(int qtyScale) async {
    await LocalStorage.saveInt(Config.qtyScaleKey, qtyScale);
  }

  static Future<String> getAccount() async {
    return await LocalStorage.get(Config.accountKey);
  }

  static setAccount(String account) async {
    await LocalStorage.saveString(Config.accountKey, account);
  }

  static Future<String> getPassword() async {
    return await LocalStorage.get(Config.passwordKey);
  }

  static setPassword(String password) async {
    await LocalStorage.saveString(Config.passwordKey, password);
  }

  static clearPassWord() async {
    await LocalStorage.remove(Config.passwordKey);
  }

  static Future<bool> isKeepPwd() async {
    return await LocalStorage.get(Config.isRememberPassKey);
  }

  static setKeepPwd(bool isKeepPwd) async {
    await LocalStorage.saveBool(Config.isRememberPassKey, isKeepPwd);
  }

  static Future<bool> isDebug() async {
    return await LocalStorage.get(Config.isDebugKey);
  }

  static setDebug(bool isDebug) async {
    await LocalStorage.saveBool(Config.isDebugKey, isDebug);
  }

  static Future<User> getUserInfo() async {
    String userInfo = await LocalStorage.get(Config.userInfoKey);
    User user;
    if (userInfo != null) {
      user = User.fromJson(json.decode(userInfo));
    }
    return user;
  }

  static setUserInfo(String userInfo) async {
    await LocalStorage.saveString(Config.userInfoKey, userInfo);
  }
}
