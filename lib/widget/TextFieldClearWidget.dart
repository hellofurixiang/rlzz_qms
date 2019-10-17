import 'package:flutter/material.dart';

///自带清除图标文本框
class TextFieldClearWidget extends StatefulWidget {
  ///描述文字
  final String hintText;

  ///文本控制器
  final TextEditingController controller;

  ///回车事件
  final Function onSubmitted;

  ///描述文字是否居中显示
  final bool isCenter;

  final bool autofocus;

  TextFieldClearWidget(
      {Key key,
      this.hintText,
      this.controller,
      this.onSubmitted,
      this.isCenter: false,
      this.autofocus: false});

  @override
  TextFieldClearWidgetState createState() => new TextFieldClearWidgetState();
}

class TextFieldClearWidgetState extends State<TextFieldClearWidget> {
  @override
  initState() {
    super.initState();
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.white,
          border:
              new Border.all(color: Theme.of(context).primaryColor, width: 0.3),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColorDark, blurRadius: 4.0)
          ]),
      padding: new EdgeInsets.only(
        left: 20.0,
        top: 12.0,
        right: 20.0,
        bottom: 12.0,
      ),
      child: new Row(children: <Widget>[
        new Expanded(
            child: new TextField(
          textAlign: widget.isCenter ? TextAlign.center : TextAlign.start,
          autofocus: widget.autofocus,
          decoration: new InputDecoration(
            hintText: widget.hintText,
            suffixIcon: isShow
                ? new IconButton(
                    icon: new Icon(
                      Icons.clear,
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {
                        isShow = false;
                      });
                    },
                  )
                : null,
          ),
          controller: widget.controller,
          onChanged: (v) {
            setState(() {
              if (v != '') {
                isShow = true;
              } else {
                isShow = false;
              }
            });
          },
          onSubmitted: (v) {
            widget.onSubmitted();
          },
        )),
      ]),
    );
  }
}
