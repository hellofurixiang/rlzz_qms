import 'package:flutter/material.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///弹框页面
class DialogPage extends StatefulWidget {
  ///标题
  final String title;

  ///主内容控件
  final Widget mainWidget;

  ///宽度占比
  final double widthProportion;

  ///宽高占比
  final double heightProportion;

  final List<Widget> btnList;

  final bool clickTransparencyHide;

  DialogPage(
      {Key key,
      @required this.mainWidget,
      this.widthProportion: 0.5,
      this.heightProportion: 0.6,
      @required this.btnList,
      this.title,
      this.clickTransparencyHide: false})
      : super(key: key);

  @override
  DialogPageState createState() => DialogPageState();
}

class DialogPageState extends State<DialogPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = CommonUtil.getScreenHeight(context);

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (widget.clickTransparencyHide) {
                Navigator.pop(context);
              }
            },
            child: Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              alignment: Alignment.center,
              width: width * widget.widthProportion,
              height: height * widget.heightProportion,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: SetColors.lightGray,
                      borderRadius:
                          new BorderRadius.vertical(top: Radius.circular(6.0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SetConstants.normalTextSize),
                    ),
                  ),
                  new Expanded(child: widget.mainWidget),
                  new Container(
                    //color: RLZZColors.lightGray,
                    decoration: BoxDecoration(
                      color: SetColors.lightGray,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0)),
                    ),
                    padding:
                        new EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.btnList,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
