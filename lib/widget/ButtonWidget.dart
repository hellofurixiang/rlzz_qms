import 'package:flutter/material.dart';
import 'package:qms/common/style/Styles.dart';

///操作按钮
class ButtonWidget extends StatefulWidget {
  ///背景色
  final Color backgroundColor;
  final double width;
  final double height;
  final String text;
  final double fontSize;
  final Color fontColor;

  ///回调函数
  final Function clickFun;

  ButtonWidget(
      {Key key,
      this.backgroundColor,
      this.width: 90.0,
      this.height: 25.0,
      this.text,
      this.fontSize: RLZZConstant.smallTextSize,
      this.clickFun,
      this.fontColor: Colors.white})
      : super(key: key);

  @override
  ButtonWidgetState createState() => new ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
        left: 2.5,
        right: 2.5,
      ),
      decoration: new BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
      ),
      width: widget.width,
      height: widget.height,
      child: new FlatButton(
        onPressed: () {
          widget.clickFun();
        },
        child: new Text(
          widget.text,
          style:
              new TextStyle(color: widget.fontColor, fontSize: widget.fontSize),
        ),
      ),
    );
  }
}
