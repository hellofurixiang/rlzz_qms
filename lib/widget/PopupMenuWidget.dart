import 'package:flutter/material.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

///操作列表
class PopupMenuWidget extends StatefulWidget {
  ///项目列表
  final List<String> itemList;

  ///回调函数
  final Function callBack;

  PopupMenuWidget({Key key, @required this.itemList, @required this.callBack})
      : super(key: key);

  @override
  PopupMenuWidgetState createState() => new PopupMenuWidgetState();
}

class PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  initState() {
    super.initState();
  }

  ///项目
  Widget getItemList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < widget.itemList.length; i++) {
      widgetList.add(new GestureDetector(
        onTap: () {
          widget.callBack(i);
        },
        child: new Container(
          alignment: Alignment.center,
          height: 30.0,
          child: new Text(widget.itemList[i]),
        ),
      ));
      widgetList.add(WidgetUtil.getDivider());
    }
    return new ListView(
      children: widgetList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Stack(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          new Center(
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white,
              width: width * 0.3,
              height: 30.0 * widget.itemList.length,
              child: getItemList(),
            ),
          ),
        ],
      ),
    );
  }
}
