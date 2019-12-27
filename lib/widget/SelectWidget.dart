import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms/common/style/Styles.dart';

///单选列表
class SelectWidget extends StatefulWidget {
  ///描述文字
  final String selectText;
  final String selectValue;
  final double fontSize;
  final double fontColor;

  ///选项列表
  final Map<String, Object> selectMap;
  final Function callFun;

  SelectWidget(
      {Key key,
      this.fontSize: SetConstants.smallTextSize,
      this.fontColor,
      this.selectText,
      this.selectValue,
      @required this.selectMap,
      @required this.callFun});

  @override
  SelectWidgetState createState() => new SelectWidgetState();
}

class SelectWidgetState extends State<SelectWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.selectMap['text'];

    double width = 20.0;

    if (text.length < 4) {
      width = 80.0;
    } else {
      width += text.length * 14;
    }

    return new GestureDetector(
      onTap: () {
        widget.callFun(widget.selectMap['value']);
      },
      child: new Material(
        color:
            widget.selectMap['isSelect'] ? Colors.white : SetColors.lightGray,
        shape: new StadiumBorder(
          side: new BorderSide(
              color: widget.selectMap['isSelect']
                  ? SetColors.mainColor
                  : SetColors.lightGray,
              width: 0.8,
              style: BorderStyle.solid),
        ),
        child: new Container(
          width: width,
          height: 25.0,
          alignment: Alignment.center,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.selectMap['isSelect']
                  ? new Container(
                      margin: new EdgeInsets.only(right: 2.0),
                      width: 12.0,
                      height: 12.0,
                      child: new SvgPicture.asset(SetIcons.correct,
                          color: SetColors.mainColor),
                    )
                  : new Container(),
              new Container(
                child: new Text(
                  widget.selectMap['text'],
                  style: TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.selectMap['isSelect']
                          ? SetColors.mainColor
                          : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
