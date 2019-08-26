import 'package:flutter/material.dart';
import 'package:qms/common/style/Styles.dart';

///文本框
class TextWidget extends StatefulWidget {
  final String text;

  ///点击
  final Function onTapFun;

  ///居中
  final bool isCenter;

  ///显示高度
  final double height;

  ///显示宽度
  final double width;

  ///文本框填充颜色
  final Color textFillColor;

  ///文本框父控件填充颜色
  final Color containerFillColor;

  ///字体颜色、大小
  final Color textColor;
  final double textSize;

  ///文本后面追加的控件
  final Widget iconWidget;

  ///文本控件
  final Widget textWidget;

  final EdgeInsets margin;

  TextWidget(
      {this.isCenter: false,
      this.height: 25.0,
      this.textFillColor: RLZZColors.lightLightGrey,
      this.containerFillColor: RLZZColors.lightLightGrey,
      this.textColor: Colors.black,
      this.textSize: RLZZConstant.normalTextSize,
      this.text,
      this.onTapFun,
      this.iconWidget,
      this.width,
      this.textWidget,
      this.margin});

  @override
  TextWidgetState createState() => new TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: widget.height,
      width: widget.width,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: widget.containerFillColor,
      ),
      margin: widget.margin ?? new EdgeInsets.all(0.001),
      padding: new EdgeInsets.all(2.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new GestureDetector(
              onTap: () {
                if (null != widget.onTapFun) {
                  widget.onTapFun();
                }
              },
              child: new Container(
                //height: widget.height,
                color: Colors.white, //widget.containerFillColor,
                alignment:
                    widget.isCenter ? Alignment.center : Alignment.centerLeft,
                /*padding: new EdgeInsets.only(
                  bottom: 2.0,
                ),*/
                child: widget.textWidget ??
                    new Text(
                      widget.text ?? '',
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: new TextStyle(
                        fontSize: widget.textSize,
                        color: widget.textColor,
                      ),
                    ),
              ),
            ),
          ),
          Center(
            child: widget.iconWidget ?? new Container(),
          ),
        ],
      ),
    );
  }
}
