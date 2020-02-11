import 'package:flutter/material.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

///列表头部筛选
class ListTopFilterWidget extends StatefulWidget {
  ListTopFilterWidget({this.text: StringZh.filter, this.onPressed});

  final String text; //描述文字
  final Function onPressed; //点击事件

  @override
  ListTopFilterWidgetState createState() => new ListTopFilterWidgetState();
}

class ListTopFilterWidgetState extends State<ListTopFilterWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      color: SetColors.lightGray,
      alignment: Alignment.centerRight,
      child: new Stack(
        alignment: Alignment.centerLeft,
        overflow: Overflow.visible,
        children: <Widget>[
          new Positioned(
            child: new Container(
              width: 20.0,
              height: 20.0,
              child: new Image(
                image: new AssetImage(SetIcons.filter),
                width: 20.0,
                height: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          new Container(
            width: 65.0,
            child: new FlatButton(
              onPressed: () {
                widget.onPressed();
              },
              child: new Text(widget.text),
            ),
          )
        ],
      ),
    );
  }
}
