import 'package:flutter/material.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///头部导航栏
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  ///标题
  final String title;

  ///是否有返回
  final bool isBack;

  ///背景颜色
  final Color backgroundColor;

  ///返回图标
  final IconData backIcon;

  ///返回图标颜色
  final Color iconColor;

  ///标题颜色
  final Color titleColor;

  ///右侧控件
  final Widget rightWidget;

  ///下面控件
  final Widget bottomWidget;

  ///返回方法
  final Function backFun;

  const AppBarWidget(
      {Key key,
      @required this.title,
      this.isBack: true,
      this.backIcon: Icons.arrow_back,
      this.backgroundColor: SetColors.mainColor,
      this.iconColor: Colors.white,
      this.titleColor: Colors.white,
      this.rightWidget,
      this.bottomWidget,
      this.backFun})
      : super(key: key);

  @override
  AppBarWidgetState createState() => new AppBarWidgetState();

  // TODO: implement preferredSize
  @override
  Size get preferredSize {
    return new Size.fromHeight(56.0);
  }
}

class AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double paddingRight = 0.0;

    List<Widget> list = new List();
    if (widget.isBack) {
      if (null == widget.rightWidget) {
        paddingRight = 48.0;
      }
      list.add(new IconButton(
        icon: new Icon(
          widget.backIcon,
          color: widget.iconColor,
        ),
        tooltip: StringZh.back,
        onPressed: () {
          if (null != widget.backFun) {
            widget.backFun();
          } else {
            Navigator.pop(context);
          }
        },
      ));
    }
    list.add(new Expanded(
      child: new Container(
        padding: new EdgeInsets.only(
          right: paddingRight,
        ),
        alignment: Alignment.center,
        child: new Text(
          widget.title,
          style: new TextStyle(
              color: widget.titleColor, fontSize: SetConstants.bigTextSize),
        ),
      ),
    ));
    if (null != widget.rightWidget) {
      list.add(
        new Container(
          width: 48.0,
          alignment: Alignment.center,
          padding: new EdgeInsets.only(
            right: 10.0,
          ),
          child: widget.rightWidget,
        ),
      );
    }

    return new Container(
      padding: new EdgeInsets.only(
        top: CommonUtil.getStatusBarHeight(context),
      ),
      height: 65.0,
      color: widget.backgroundColor,
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list),
    );
  }
}
