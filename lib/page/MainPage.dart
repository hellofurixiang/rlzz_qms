import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/MenuConfig.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/AppBarWidget.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    initInfo('');
  }

  ///初始化数据
  void initInfo(var obj) async {
    QmsService.getTestOrderStatistical(context, (data) {
      Map<String, dynamic> map = data;
      setState(() {
        getMenuInfo(map);
      });
    }, (err) {});

    await CommonUtil.requestPermission();
  }

  getMenuInfo(Map<String, dynamic> map) {
    for (int i = 0; i < menuConfig.qmsMenuList.length; i++) {
      List list = menuConfig.qmsMenuList[i]['menus'];
      for (int k = 0; k < list.length; k++) {
        list[k]['count'] = map[list[k]['code']];
      }
    }
  }

  MenuConfig menuConfig = new MenuConfig();

  buildListItem() {
    List<Widget> widgetList = [];

    List items = menuConfig.qmsMenuList;

    List<String> resources = GlobalInfo.instance.getUserPermissions();

    ///一行三列
    var crossAxisCount = 3;

    bool isDebug = GlobalInfo.instance.isDebug();

    for (var item in items) {
      bool bo = false;
      for (var menu in item['menus']) {
        if (isDebug) {
          menu['isShow'] = true;
          bo = true;
        } else {
          if(resources.length==0){
            menu['isShow'] = true;
            bo = true;
          }else {
            if (resources.contains(menu['permissions'])) {
              menu['isShow'] = true;
              bo = true;
            } else {
              menu['isShow'] = false;
            }
          }
        }
      }
      if (!bo) {
        continue;
      }
      widgetList.add(WidgetUtil.buildListItem(context, item, crossAxisCount,
          mainAxisAlignment: MainAxisAlignment.start, backCall: initInfo));
    }

    if (widgetList.length == 0) {
      widgetList.add(
        new Container(
          height: 100.0,
          padding: new EdgeInsets.all(5.0),
          child: new Align(
            alignment: Alignment.center,
            child: new Text(StringZh.noMenuPermissions,
                textAlign: TextAlign.start),
          ),
        ),
      );
    }
    return widgetList;
  }

  ///退出
  void _logout() {
    ApiUtil.logout(context, _successCallBack);
  }

  void _successCallBack(data) async {
    await CommonUtil.clearUserInfo();

    ///使用情况：例如 当用户点击了退出登录时，
    ///我们需要进入某一个页面（比如点退出登录后进入了登录页），
    ///这个时候用户点击返回时不应该能进入任何一个页面，这种情况就可以使用。
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Config.login, (Route<dynamic> route) => false);

    //Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        WidgetUtil.dialogExitApp(context);
      },
      child: new Scaffold(
        appBar: new AppBarWidget(
          title: StringZh.qms_describe,
          isBack: false,
          rightWidget: new GestureDetector(
            onTap: () {
              _logout();
            },
            child: new Text(
              StringZh.cancellation,
              style: new TextStyle(color: Colors.white),
            ),
          ),
        ),
        body:
            //backgroundColor: Colors.,
            new ListView(
          //itemCount: menuConfig.qmsMenuList.length,
          children: buildListItem(),
        ),
      ),
    );
  }
}
