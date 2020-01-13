import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/local/MySelfInfo.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/AppBarWidget.dart';

///服务地址信息设置
class ServiceSettingPage extends StatefulWidget {
  @override
  ServiceSettingPageState createState() => new ServiceSettingPageState();
}

class ServiceSettingPageState extends State<ServiceSettingPage> {
  var textHeight = 20.0;

  EdgeInsets margin = new EdgeInsets.only(top: 5.0);

  ///接口协议、地址、端口号、目录
  var protocol = Config.protocol;

  TextEditingController ipController = new TextEditingController();
  TextEditingController postController = new TextEditingController();
  TextEditingController catalogController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    ipController.dispose();
    postController.dispose();
    catalogController.dispose();
    super.dispose();
  }

  ///初始化数据
  void initInfo() async {
    var pro = await MySelfInfo.getProtocol();
    protocol = pro ?? Config.protocol;

    ipController.text = await MySelfInfo.getIP();
    String post = await MySelfInfo.getPost();
    postController.text = post ?? Config.post;
    var catalog = await MySelfInfo.getCatalog();
    catalogController.text = catalog ?? Config.catalog;
  }

  ///接口协议列表
  List<DropdownMenuItem> generateItemList() {
    List<DropdownMenuItem> items = new List();
    items.add(new DropdownMenuItem(
        value: Config.protocol, child: new Text(Config.protocol)));
    items.add(new DropdownMenuItem(
        value: Config.protocols, child: new Text(Config.protocols)));
    return items;
  }

  ///保存设置
  void _saveSettingInfo(BuildContext context, bool isDebug) async {
    var ip = ipController.text;
    var post = postController.text;

    if ('' == ip) {
      Fluttertoast.showToast(msg: StringZh.prompt_address);
      return;
    }
    if ('' == post) {
      Fluttertoast.showToast(msg: StringZh.prompt_post);
      return;
    }

    WidgetUtil.showLoadingDialog(context, StringZh.setting_text);

    await MySelfInfo.removeSetting();

    await MySelfInfo.setToken("");

    GlobalInfo.instance.setDebug(isDebug);

    //bool isDebug = await MySelfInfo.isDebug();

    ///调试状态
    /*if (isDebug) {
      _testSuccess('');
      return;
    }*/

    ///测试服务器网络是否正常
    ApiUtil.testNetwork(context, protocol, ip, post, _testSuccess, _testFail);
  }

  void _testSuccess(data) async {
    var ip = ipController.text;
    var post = postController.text;
    var catalog = catalogController.text;

    await MySelfInfo.setProtocol(protocol);
    await MySelfInfo.setIP(ip);
    await MySelfInfo.setPost(post);
    await MySelfInfo.setCatalog(catalog);

    await MySelfInfo.removeToken();
    await MySelfInfo.remove(Config.sobKey);

    Navigator.pop(context);

    Fluttertoast.showToast(msg: StringZh.connection);
    ipController.clear();
    postController.clear();
    catalogController.clear();

    ///回退到登录页面
    Navigator.pop(context, 'setting');
  }

  void _testFail(String err) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width;
    if (CommonUtil.checkIsLargeScreen(context)) {
      width = CommonUtil.getScreenWidth(context) * 0.3;
    } else {
      width = CommonUtil.getScreenWidth(context) * 0.8;
    }

    return new Scaffold(
      appBar: new AppBarWidget(
        title: StringZh.setting_title,
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: width,
                      height: textHeight,
                      margin: new EdgeInsets.only(top: 20.0),
                      child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(StringZh.setting_protocol,
                            textAlign: TextAlign.start),
                      )),
                  new Container(
                    width: width,
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: new BorderSide(color: Colors.black45))),
                    child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                      items: generateItemList(),
                      onChanged: (value) {
                        setState(() {
                          protocol = value;
                        });
                      },
                      value: protocol,
                    )),
                  ),
                  new Container(
                      width: width,
                      height: textHeight,
                      margin: margin,
                      child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          StringZh.setting_address,
                          textAlign: TextAlign.start,
                        ),
                      )),
                  new Container(
                    width: width,
                    child: new TextField(
                      controller: ipController,
                    ),
                  ),
                  new Container(
                      width: width,
                      margin: margin,
                      height: textHeight,
                      child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          StringZh.setting_post,
                          textAlign: TextAlign.start,
                        ),
                      )),
                  new Container(
                    width: width,
                    child: new TextField(
                      maxLines: 1,
                      //键盘展示为号码
                      keyboardType: TextInputType.phone,
                      //只能输入数字
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      controller: postController,
                    ),
                  ),
                  new Container(
                      width: width,
                      height: textHeight,
                      margin: margin,
                      child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          StringZh.setting_catalog,
                          textAlign: TextAlign.start,
                        ),
                      )),
                  new Container(
                    width: width,
                    child: new TextField(
                      controller: catalogController,
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      _saveSettingInfo(context, false);
                    },
                    onLongPress: () {
                      _saveSettingInfo(context, true);
                    },
                    child: new Container(
                      margin: new EdgeInsets.only(top: 20.0),
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
                          StringZh.save,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: SetConstants.bigTextSize),
                        ),
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
