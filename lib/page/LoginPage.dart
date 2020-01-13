import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/DeviceUtil.dart';
import 'package:qms/common/utils/plugin/PackageInfo.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  ///
  TextStyle textTips = new TextStyle(color: Colors.black);
  TextStyle hintTips = new TextStyle();
  String logo = 'assets/images/splash.png';

  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _accountController = new TextEditingController();

  ///登录日期
  String dateStr = '';

  ///密码是否明文
  var obscureText = true;

  ///记住密码
  bool isKeepPwd = false;

  ///选中账套
  String selectItemValue = '';

  List<DropdownMenuItem> sobItems = [
    new DropdownMenuItem(value: '', child: new Text(StringZh.selectFirstItem))
  ];

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initInfo();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  ///获取程序相关信息
  void _initPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      _packageInfo = packageInfo;
    });
  }

  ///初始化信息
  void _initInfo() async {
    bool bo = await MySelfInfo.isKeepPwd();

    setState(() {
      isKeepPwd = bo ?? false;
    });

    String account = await MySelfInfo.getAccount();
    _accountController.text = account ?? '';

    if (isKeepPwd) {
      String password = await MySelfInfo.getPassword();
      _passwordController.text = password ?? '';
    }

    String loginDate = await MySelfInfo.getLoginDate();
    dateStr = loginDate ?? DateTime.now().toIso8601String().substring(0, 10);

    ///网络连接判断
    /*var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: '网络连接异常，请检查网络', timeInSecForIos: 3);
      return;
    }*/

    _getSobs();
  }

  void _getSobs() {
    ///获取账套
    ApiUtil.getSobs(context, _getSobsSuccess);
  }

  void _getSobsSuccess(data) async {
    Map<String, dynamic> sobs = data;

    ///账套
    String sob = await MySelfInfo.getSob();
    sobItems.clear();
    sobs.forEach((key, val) {
      DropdownMenuItem item =
          new DropdownMenuItem(value: key, child: new Text(val));
      sobItems.add(item);
    });

    if (sobItems.length == 0) {
      return;
    }
    if (sob != null && sobs.containsKey(sob)) {
      setState(() {
        selectItemValue = sob;
      });
    } else {
      setState(() {
        selectItemValue = sobItems[0].value;
      });
    }
  }

  ///登录
  void _login(BuildContext context) async {
    var username = _accountController.text;
    var password = _passwordController.text;
    //var loginDate = _loginDateController.text;

    if ('' == username) {
      Fluttertoast.showToast(msg: StringZh.prompt_account);
      return;
    }
    if ('' == password) {
      Fluttertoast.showToast(msg: StringZh.prompt_password);
      return;
    }
    if ('' == dateStr) {
      Fluttertoast.showToast(msg: StringZh.prompt_login_date);
      return;
    }

    if ('' == selectItemValue) {
      Fluttertoast.showToast(msg: StringZh.prompt_sob);
      return;
    }

    await MySelfInfo.setSob(selectItemValue);

    WidgetUtil.showLoadingDialog(context, StringZh.logining);

    Map<String, String> params = {
      'username': username,
      'password': password,
      'device': await DeviceUtil.getIdentity(),
      'sob': selectItemValue,
      'workDate': dateStr
    };

    ApiUtil.login(context, params, _loginSuccess, _loginFail);
  }

  _saveInfo(token) async {
    ///登录成功保存登录信息
    await MySelfInfo.setKeepPwd(isKeepPwd);
    if (isKeepPwd) {
      await MySelfInfo.setAccount(_accountController.text);
      await MySelfInfo.setPassword(_passwordController.text);
      await MySelfInfo.setLoginDate(dateStr);
    }
    await MySelfInfo.setToken(token);
    GlobalInfo.instance.setLoginDate(dateStr);
    GlobalInfo.instance.setAccount(_accountController.text);
  }

  void _loginSuccess(String token) async {
    await _saveInfo(token);

    //Navigator.pop(context);
    //Navigator.pushNamed(context, '/mainPage');

    ApiUtil.getUserInfoAndConfig(context, _accountController.text, () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Config.mainPage);
    }, (errorMsg) {
      Navigator.pop(context);
    });
  }

  void _loginFail(String errorMsg) {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: StringZh.login_failure + errorMsg, timeInSecForIos: 3);
  }

  ///登录日期
  void _selectDate(BuildContext context) {
    WidgetUtil.getSelectDate(context, DateTime.parse(dateStr), (dt) {
      setState(() {
        dateStr = dt;
      });
    });
  }

  ///跳转到设置页面，并接收返回值，刷新帐套列表
  void _goToSetting(BuildContext context) {
    Navigator.pushNamed(context, Config.serviceSetting).then((onValue) {
      if (onValue != null) {
        _getSobs();
      }
    });
  }

  FocusNode passwordTextFieldNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width;
    if (CommonUtil.checkIsLargeScreen(context)) {
      width = CommonUtil.getScreenWidth(context) * 0.3;
    } else {
      width = CommonUtil.getScreenWidth(context) * 0.8;
    }

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        WidgetUtil.dialogExitApp(context);
      },
      child: new Scaffold(
        body: new ListView(
          children: <Widget>[
            new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(
                      top: CommonUtil.getStatusBarHeight(context),
                    ),
                  ),
                  new Image.asset(
                    logo,
                    width: 100.0,
                    height: 100.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    width: width,
                    child: new TextField(
                      //autofocus: true,
                      style: textTips,
                      controller: _accountController,
                      decoration: InputDecoration(
                        hintText: StringZh.account,
                        suffixIcon: new Icon(
                          Icons.person,
                        ),
                      ),
                      onEditingComplete: () {
                        if ('' == _accountController.text) {
                          Fluttertoast.showToast(msg: StringZh.prompt_account);
                          return;
                        }
                        FocusScope.of(context)
                            .requestFocus(passwordTextFieldNode);
                      },
                    ),
                  ),
                  new Container(
                    width: width,
                    child: new TextField(
                      focusNode: passwordTextFieldNode,
                      style: textTips,
                      controller: _passwordController,
                      onEditingComplete: () {
                        if ('' == _passwordController.text) {
                          Fluttertoast.showToast(msg: StringZh.prompt_password);
                          return;
                        }
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: StringZh.password,
                        suffixIcon: new IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: (obscureText
                              ? new Icon(
                                  Icons.visibility_off,
                                )
                              : new Icon(
                                  Icons.visibility,
                                )),
                        ),
                      ),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: new Container(
                      width: width,
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(color: Colors.black45))),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(dateStr),
                            new IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              icon: new Icon(
                                Icons.calendar_today,
                                color: SetColors.gray,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  new Container(
                    width: width,
                    height: 40.0,
                    margin: new EdgeInsets.only(top: 5.0),
                    padding: new EdgeInsets.only(left: 2.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: new BorderSide(color: Colors.black45))),
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        items: sobItems,
                        onChanged: (value) {
                          setState(() {
                            selectItemValue = value;
                          });
                        },
                        value: selectItemValue,
                        hint: new Text(StringZh.prompt_sob),
                        style: textTips,
                      ),
                    ),
                  ),
                  new Container(
                    width: width,
                    height: 40.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text.rich(
                          new TextSpan(
                            text: StringZh.login_setting,
                            style: new TextStyle(
                                fontSize: SetConstants.smallTextSize),
                            children: [
                              new TextSpan(
                                text: StringZh.setting,
                                style: new TextStyle(
                                    fontSize: SetConstants.smallTextSize,
                                    color: SetColors.mainColor),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    _goToSetting(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isKeepPwd = !isKeepPwd;
                                  });
                                },
                                child: new Container(
                                  child: new Icon(
                                    isKeepPwd
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: isKeepPwd
                                        ? SetColors.mainColor
                                        : Colors.grey,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                              new Text(
                                StringZh.remember_password,
                                style: new TextStyle(
                                    fontSize: SetConstants.smallTextSize),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      _login(context);
                    },
                    child: new Container(
                      margin: new EdgeInsets.only(top: 10.0),
                      decoration: new BoxDecoration(
                        color: SetColors.mainColor,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(6.0)),
                      ),
                      //color: RLZZColors.mainColor,
                      width: width,
                      height: 40.0,
                      child: new Center(
                        child: new Text(
                          StringZh.login,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: SetConstants.bigTextSize),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.bottomRight,
                    width: width,
                    height: 40.0,
                    child: new Text.rich(
                      new TextSpan(
                        text: StringZh.version,
                        style: new TextStyle(
                            fontSize: 9.0, color: SetColors.darkDarkGrey),
                        children: [
                          new TextSpan(
                            text: _packageInfo.version,
                            style: new TextStyle(
                                fontSize: 9.0, color: SetColors.darkDarkGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
