import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/page/ArrivalTestOrderListPage.dart';
import 'package:qms/page/ArrivalWaitTaskListPage.dart';
import 'package:qms/page/CompleteTestOrderListPage.dart';
import 'package:qms/page/CompleteWaitTaskListPage.dart';
import 'package:qms/page/IQCTestOrderListPage.dart';
import 'package:qms/page/LoginPage.dart';
import 'package:qms/page/SplashPage.dart';
import 'package:qms/page/MainPage.dart';
import 'package:qms/page/ServiceSettingPage.dart';

void main() => FlutterBugly.postCatchedException(() {
      if (Config.screenMode) {
        // 强制竖屏
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      } else {
        // 强制横屏
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
      }
      runApp(new MyApp());
    });

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterBugly.init(
        androidAppId: Config.buglyAppId, iOSAppId: "your iOS app id");
  }

  final routes = <String, WidgetBuilder>{
    Config.login: (BuildContext context) => new LoginPage(),
    Config.splash: (BuildContext context) => new SplashPage(),
    Config.serviceSetting: (BuildContext context) => new ServiceSettingPage(),
    Config.mainPage: (BuildContext context) => new MainPage(),
    Config.arrivalWaitTaskListPage: (BuildContext context) =>
        new ArrivalWaitTaskListPage(),
    Config.arrivalTestOrderListPage: (BuildContext context) =>
        new ArrivalTestOrderListPage(),
    Config.iQCTestOrderListPage: (BuildContext context) =>
        new IQCTestOrderListPage(),
    Config.completeWaitTaskListPage: (BuildContext context) =>
        new CompleteWaitTaskListPage(),
    Config.completeTestOrderListPage: (BuildContext context) =>
        new CompleteTestOrderListPage(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, // 设置这一属性即可去掉右上角debug
        home: LoginPage(), //SignPage(),
        routes: routes);
  }
}

/*void main() => runApp(MaterialApp(home: TextViewExample()));

class TextViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter TextView example')),
        body: Column(children: [
          Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  width: 130.0,
                  height: 100.0,
                  child: TextView(
                    onTextViewCreated: _onTextViewCreated,
                  ))),
          Expanded(
              flex: 3,
              child: Container(
                  color: Colors.blue[100],
                  child: Center(child: Text("Hello from Flutter!"))))
        ]));
  }

  void _onTextViewCreated(TextViewController controller) {
    controller.setText('Hello from Android!');
  }
}*/
