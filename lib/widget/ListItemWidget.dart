import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/style/Styles.dart';

///列表项
class ListItemWidget extends StatefulWidget {
  ListItemWidget(
      {this.index: '',
      @required this.child,
      this.onTap,
      this.isShowIndex: true,
      this.onLongPress});

  ///序号
  final String index;

  ///子控件
  final Widget child;

  ///显示序号
  final bool isShowIndex;

  ///行点击
  final Function onTap;

  ///长按
  final Function onLongPress;

  @override
  ListItemWidgetState createState() => new ListItemWidgetState();
}

class ListItemWidgetState extends State<ListItemWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget indexWidget;
    if (null != widget.index && '' != widget.index) {
      indexWidget = new Container(
        alignment: Alignment.center,
        width: Config.screenMode ? 20.0 : 40.0,
        child: new Material(
          borderRadius: BorderRadius.circular(100.0),
          color: RLZZColors.mainColor,
          child: new Padding(
              padding: new EdgeInsets.all(2.5),
              child: new Text(
                widget.index,
                style: new TextStyle(
                    color: Colors.white, fontSize: RLZZConstant.smallTextSize),
              )),
        ),
        margin: new EdgeInsets.only(
          right: 5.0,
        ),
      );
    } else {
      indexWidget = new Container();
    }
    return new GestureDetector(
      onLongPress: () {
        if (null == widget.onLongPress) return;
        widget.onLongPress();
      },
      onTap: () {
        if (null == widget.onTap) return;
        widget.onTap();
      },
      child: new Card(
        child: new Padding(
          padding: new EdgeInsets.all(2.0),
          child: new Row(
            children: <Widget>[
              indexWidget,
              new Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
