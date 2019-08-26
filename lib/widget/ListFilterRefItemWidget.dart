import 'package:flutter/material.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/widget/RefBasicWidget.dart';
import 'package:qms/common/modal/FilterModel.dart';

class ListFilterRefItemWidget extends StatefulWidget {
  ///项目名称
  final FilterModel filterModel;

  final List<FilterModel> itemList;

  final Function callBack;

  ///描述文本宽度
  final double labelWidth;

  ///前缀字体颜色、大小
  final Color labelColor;
  final double labelSize;

  ///选择字体颜色、大小
  final Color textColor;
  final double textSize;

  ///控件高度
  final double height;

  ListFilterRefItemWidget(
      {Key key,
      @required this.filterModel,
      this.itemList,
      this.callBack,
      this.labelColor: Colors.black,
      this.labelSize: RLZZConstant.normalTextSize,
      this.textColor: Colors.black,
      this.textSize: RLZZConstant.normalTextSize,
      this.labelWidth,
      this.height: 40.0})
      : super(key: key);

  @override
  ListFilterRefItemWidgetState createState() =>
      new ListFilterRefItemWidgetState();
}

class ListFilterRefItemWidgetState extends State<ListFilterRefItemWidget> {
  @override
  initState() {
    super.initState();
  }

  final GlobalKey<RefBasicWidgetState> _refKey =
      GlobalKey<RefBasicWidgetState>();

  ///显示参照
  void _showRefSlider(String refFlag, String title, bool hasAll) {
    showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new RefBasicWidget(
          key: _refKey,
          filterModel: widget.filterModel,
          itemList: widget.itemList,
          callBack: (RefBasic refData) {
            setState(() {
              widget.filterModel.initParam = refData;

              ///清空相关参照数据
              widget.callBack();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget labelWidget;
    if (null == widget.labelWidth) {
      labelWidget = new Container(
        margin: new EdgeInsets.only(
          left: 8.0,
          right: 4.0,
        ),
        child: new Text(
          widget.filterModel.itemName,
          style: new TextStyle(
              fontSize: widget.labelSize, color: widget.labelColor),
        ),
      );
    } else {
      labelWidget = new Container(
        width: widget.labelWidth,
        alignment: Alignment.centerRight,
        margin: new EdgeInsets.only(
          left: 8.0,
          right: 4.0,
        ),
        child: new Text(
          widget.filterModel.itemName,
          style: new TextStyle(
              fontSize: widget.labelSize, color: widget.labelColor),
        ),
      );
    }

    return new Container(
      height: widget.height,
      child: new Row(
        children: <Widget>[
          labelWidget,
          new Expanded(
            child: new GestureDetector(
              onTap: () {
                _showRefSlider(widget.filterModel.refFlag,
                    widget.filterModel.title, widget.filterModel.hasAll);
              },
              child: new Text(
                widget.filterModel.initParam.arcName,
                textAlign: TextAlign.end,
                style: new TextStyle(
                    fontSize: widget.textSize, color: widget.textColor),
              ),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            width: 40,
            height: 35,
            child: new IconButton(
                iconSize: 20.0,
                icon: Icon(Icons.keyboard_arrow_right),
                color: RLZZColors.darkGrey,
                onPressed: () {
                  _showRefSlider(widget.filterModel.refFlag,
                      widget.filterModel.title, widget.filterModel.hasAll);
                }),
          ),
        ],
      ),
    );
  }
}
