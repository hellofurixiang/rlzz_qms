import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  startTime() async {
    ///设置启动图生效时间
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    ///使用情况：例如 从SplashScreen到HomeScreen。
    ///它应该只显示一次，用户不应该再从主屏幕回到它。
    ///在这种情况下，由于我们将要进入一个全新的屏幕，
    ///我们可能想要使用这个方法来实现它的enter animation属性。
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: RLZZColors.mainColor,
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/images/splash.png',
              width: 120.0,
              height: 140.0,
              //fit: BoxFit.cover,        //告诉引用图片的控件，图像应尽可能小，但覆盖整个控件。
            ),
            new Text(
              StringZh.splash_text1,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: RLZZConstant.hugeTextSize,
                decoration: TextDecoration.none,
              ),
            ),
            new Text(
              StringZh.splash_text2,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: RLZZConstant.middleTextSize,
                decoration: TextDecoration.none,
              ),
            ),
            new Text(
              StringZh.splash_text3,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: RLZZConstant.middleTextSize,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
