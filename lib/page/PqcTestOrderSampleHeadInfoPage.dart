import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/widget/InputWidget.dart';

///检验单详情
class PqcTestOrderSampleHeadInfoPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///新增状态
  final bool isAdd;

  ///审核状态
  final bool auditStatus;

  PqcTestOrderSampleHeadInfoPage({
    Key key,
    @required this.testOrderInfo,
    @required this.isAdd,
    @required this.auditStatus,
  }) : super(key: key);

  @override
  PqcTestOrderSampleHeadInfoPageState createState() =>
      new PqcTestOrderSampleHeadInfoPageState();
}

class PqcTestOrderSampleHeadInfoPageState
    extends State<PqcTestOrderSampleHeadInfoPage> {
  double width;


  @override
  void initState() {
    super.initState();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  void getQtyInfo(TextEditingController ctl, var val) {
    ctl.text = val == null ? '' : val.toString();
  }

  ///获取表体信息，封装控件
  Widget _getDetailInfo() {
    return new ListView(
      children: <Widget>[
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 90.0,
                child: new Text(
                  StringZh.testResult,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          margin: new EdgeInsets.only(top: 10.0),
          child: new Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  StringZh.checkoutQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.checkoutQty).toString(),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 90.0,
                child: new Text(
                  StringZh.uncheckedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.uncheckedQty).toString(),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.qualifiedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.qualifiedQty).toString(),
                ),
              ),
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 10.0),
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  StringZh.mendingQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.mendingQty).toString(),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 90.0,
                child: new Text(
                  StringZh.scrapQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.scrapQty).toString(),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.reworkQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.reworkQty).toString(),
                ),
              ),
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 10.0),
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  StringZh.mendedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.mendedQty).toString(),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 90.0,
                child: new Text(
                  StringZh.totalUnQualifiedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  initText: CommonUtil.getDoubleScale(widget.testOrderInfo.unQualifiedQty).toString(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);

    return _getDetailInfo();
  }
}
