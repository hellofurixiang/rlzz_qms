import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/widget/ButtonWidget.dart';

///备注
class RemarkWidget extends StatefulWidget {
  ///信息
  final String remark;
  final String title;

  RemarkWidget({
    Key key,
    @required this.title,
    @required this.remark,
  }) : super(key: key);

  @override
  RemarkWidgetState createState() => new RemarkWidgetState();
}

class RemarkWidgetState extends State<RemarkWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = 100.0;
    List<Widget> list = new List();
    if (null != widget.title) {
      height = 200.0;

      list.add(new Container(
          height: 30.0,
          alignment: Alignment.center,
          child: new Text(
            widget.title,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: SetColors.mainColor,
                fontSize: SetConstants.normalTextSize),
          )));

      list.add(WidgetUtil.getDivider(height: 0.5, color: SetColors.mainColor));
    }

    list.add(new Expanded(
      child: new Container(
        width: Config.screenMode ? width * 0.8 : width * 0.3,
        margin: new EdgeInsets.all(5.0),
        padding: new EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: new Text(widget.remark),
        ),
      ),
    ));

    if (null != widget.title) {
      list.add(new Container(
        padding: new EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
        ),
        alignment: Alignment.bottomRight,
        child: new ButtonWidget(
          width: 65.0,
          backgroundColor: SetColors.mainColor,
          text: StringZh.app_close,
          fontColor: Colors.white,
          clickFun: () {
            Navigator.pop(context);
          },
        ),
        decoration: new BoxDecoration(
          color: SetColors.lightLightGrey,
          borderRadius: new BorderRadius.only(
              bottomLeft: new Radius.circular(6.0),
              bottomRight: new Radius.circular(6.0)),
        ),
      ));
    }

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
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
              ),
              alignment: Alignment.center,
              width: Config.screenMode ? width * 0.8 : width * 0.3,
              height: height,
              child: new Column(
                children: list,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
