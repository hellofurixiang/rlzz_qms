import 'package:flutter/material.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

///搜索输入框
class DateInputWidget extends StatefulWidget {
  ///初始值
  final String initText;

  ///描述文本
  final String hintText;

  ///文字居中
  final bool isCenter;

  ///清除按钮回调
  final Function clearCallBack;

  ///所有边框有阴影效果
  final bool isAllBorder;

  ///输入框显示高度
  final double height;

  ///文本框填充颜色
  final Color textFillColor;

  ///文本框父控件填充颜色
  final Color containerFillColor;

  final Function onTapCall;

  DateInputWidget({
    Key key,
    this.hintText,
    this.isCenter: false,
    this.clearCallBack,
    this.height: 25.0,
    this.isAllBorder: false,
    this.initText,
    this.textFillColor: RLZZColors.lightLightGrey,
    this.containerFillColor: RLZZColors.lightLightGrey,
    this.onTapCall,
  }) : super(key: key);

  @override
  DateInputWidgetState createState() => new DateInputWidgetState();
}

class DateInputWidgetState extends State<DateInputWidget> {
  @override
  initState() {
    super.initState();
    if (null != widget.initText) initText = widget.initText;
  }

  String initText = '';

  ///清除图标显示
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    iconWidget = initText != ''
        ? new GestureDetector(
            onTap: () {
              setState(() {
                showClear = false;
                initText = '';
              });
              if (null != widget.clearCallBack) widget.clearCallBack();
            },
            child: new Container(
              alignment: Alignment.center,
              child: new Icon(
                Icons.clear,
                size: 15.0,
                color: RLZZColors.mainColor,
              ),
            ),
          )
        : new Container();

    return new Container(
      height: widget.height,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: widget.containerFillColor,
      ),
      padding: new EdgeInsets.all(2.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new GestureDetector(
              onTap: () {
                WidgetUtil.getSelectDate(context,
                    initText == '' ? DateTime.now() : DateTime.parse(initText),
                    (dt) {
                  if (null != widget.onTapCall) {
                    if (widget.onTapCall(dt)) {
                      setState(() {
                        initText = dt;
                      });
                    }
                  } else {
                    setState(() {
                      initText = dt;
                    });
                  }
                });
              },
              child: new Container(
                color: widget.containerFillColor,
                alignment: Alignment.center,
                child: new Text(
                  initText,
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.black),
                  textAlign:
                      widget.isCenter ? TextAlign.center : TextAlign.left,
                ),
              ),
            ),
          ),
          iconWidget
        ],
      ),
    );
  }
}
