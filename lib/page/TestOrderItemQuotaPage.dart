import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///检验单指标列表
class TestOrderItemQuotaPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///选中选项数据方法
  final Function changeQuotaItemInfo;

  ///滚动控制器
  final ScrollController scrollController;

  ///整单判定背景色
  final Color whole;

  TestOrderItemQuotaPage({
    Key key,
    @required this.testOrderInfo,
    @required this.changeQuotaItemInfo,
    @required this.whole,
    this.scrollController,
  }) : super(key: key);

  @override
  TestOrderItemQuotaPageState createState() =>
      new TestOrderItemQuotaPageState();
}

class TestOrderItemQuotaPageState extends State<TestOrderItemQuotaPage> {
  ///整单判定背景色
  //Color whole = RLZZColors.threeLevel;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    if (widget.scrollController == null) {
      _scrollController = new ScrollController();
    } else {
      _scrollController = widget.scrollController;
    }
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///检验项目指标
  _renderItemListInfo() {
    List<Widget> widgetList = new List();
    if (widget.testOrderInfo.testOrderDetail.length == 0) {
      widgetList.add(new Container());
      return widgetList;
    }

    String testItemCode = '';

    for (int i = 0; i < widget.testOrderInfo.testOrderDetail.length; i++) {
      TestOrderDetail v = widget.testOrderInfo.testOrderDetail[i];
      v.edited = v.edited ?? false;

      if (testItemCode != v.testItemCode) {
        ///检验项目
        widgetList.add(new Container(
          alignment: Alignment.centerLeft,
          padding: new EdgeInsets.only(left: 10.0),
          height: 30.0,
          child: new Text(
            v.testItemName,
            style: new TextStyle(
                fontSize: SetConstants.smallTextSize,
                color: SetColors.selectLevel),
          ),
          decoration: new BoxDecoration(
            color: SetColors.twoLevel,
          ),
        ));
      }

      testItemCode = v.testItemCode;

      ///检验指标
      widgetList.add(
        new GestureDetector(
          onTap: () {
            widget.changeQuotaItemInfo(i);
          },
          child: new Container(
            decoration: new BoxDecoration(
              color: v.color ?? SetColors.threeLevel,
              border: new Border(
                  top: new BorderSide(color: Colors.white, width: 0.2),
                  bottom: new BorderSide(color: Colors.white, width: 0.2)),
            ),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Container(
                  alignment: Alignment.centerLeft,
                  padding: new EdgeInsets.only(left: 20.0),
                  height: 35.0,
                  child: new Text(
                    v.testQuotaName,
                    style: new TextStyle(
                        fontSize: SetConstants.normalTextSize,
                        color: Colors.white),
                  ),
                )),
                new Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.done_all,
                    color: v.edited ? SetColors.red : Colors.transparent,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);

    return new Container(
      width: width * 0.25,
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.only(left: 5.0),
            height: 40.0,
            child: new Text(
              StringZh.testOrder_testItem_one,
              style: new TextStyle(
                  fontSize: SetConstants.bigTextSize, color: Colors.white),
            ),
            decoration: new BoxDecoration(
              color: SetColors.oneLevel,
              //border: new Border.all(color: Colors.white, width: 1.0),
            ),
          ),
          new Expanded(
            child: new ListView(
              controller: _scrollController,
              ///根据状态返回子控件
              children: _renderItemListInfo(),
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.only(left: 5.0),
            height: 40.0,
            child: new Text(
              StringZh.testOrder_testItem_two,
              style: new TextStyle(
                  fontSize: SetConstants.bigTextSize, color: Colors.white),
            ),
            decoration: new BoxDecoration(
              color: SetColors.oneLevel,
            ),
          ),
          new GestureDetector(
            onTap: () {
              widget.changeQuotaItemInfo(-1, isAll: true);
            },
            child: new Container(
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.only(left: 20.0),
              height: 35.0,
              child: new Text(
                StringZh.testOrder_result_entry,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize, color: Colors.white),
              ),
              decoration: new BoxDecoration(
                color: widget.whole,
                border: new Border(
                    bottom: new BorderSide(color: Colors.white, width: 0.2)),
              ),
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        color: SetColors.threeLevel,
        border: new Border(
            right: new BorderSide(color: SetColors.darkGrey, width: 1.0)),
      ),
    );
  }
}
