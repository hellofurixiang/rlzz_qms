import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/MenuConfig.dart';
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
    //CommonUtil.showLoadingDialog(context, '加载中...');
    QmsService.getUnHandleMessage(context, (data) {
      List<dynamic> map = data;
      /*if ('' == obj) {
        getMenuInfo(map);
      } else {*/
      setState(() {
        getMenuInfo(map);
      });
      //}
    }, (err) {
      Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
    });

    await CommonUtil.requestPermission();
  }

  getMenuInfo(List<dynamic> map) {
    for (int i = 0; i < menuConfig.qmsMenuList.length; i++) {
      List list = menuConfig.qmsMenuList[i]['menus'];
      for (int k = 0; k < list.length; k++) {
        if (i == 0) {
          if (k == 0) {
            list[k]['count'] = map[0];
          }

          if (k == 1) {
            list[k]['count'] = map[2];
          }
          if (k == 2) {
            list[k]['count'] = map[4];
          }
        }
        if (i == 1) {
          if (k == 0) {
            list[k]['count'] = map[1];
          } else {
            list[k]['count'] = map[3];
          }
        }
      }
    }
  }

  MenuConfig menuConfig = new MenuConfig();

  Widget buildListItem(BuildContext context, int index) {
    var item = menuConfig.qmsMenuList[index];

    ///一行三列
    var crossAxisCount = 3;
    return WidgetUtil.buildListItem(context, item, crossAxisCount,
        mainAxisAlignment: MainAxisAlignment.start, backCall: initInfo);
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
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

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
            new ListView.builder(
                itemCount: menuConfig.qmsMenuList.length,
                itemBuilder: buildListItem),
      ),
    );
  }
}
