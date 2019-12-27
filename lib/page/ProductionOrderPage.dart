import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/modal/ProductionOrder.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';

///生产订单
class ProductionOrderPage extends StatefulWidget {
  ///生产订单表体ID
  final String detailId;

  ///生产订单号
  final String moDocNo;

  ProductionOrderPage({
    Key key,
    @required this.detailId,
    @required this.moDocNo,
  }) : super(key: key);

  @override
  ProductionOrderPageState createState() => ProductionOrderPageState();
}

class ProductionOrderPageState extends State<ProductionOrderPage> {
  @override
  initState() {
    super.initState();
    _getDataRequest();
  }

  @override
  dispose() {
    super.dispose();
  }

  ///页面宽度
  double width;

  ProductionOrder vo = new ProductionOrder.empty();

  bool loading = true;

  ///初始化数据
  void _getDataRequest() {
    QmsService.getProductionOrderInfo(context, widget.moDocNo, widget.detailId,
        (res) {
      setState(() {
        vo = ProductionOrder.fromJson(res);
        loading = false;
      });
    }, (err) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
      Navigator.pop(context);
    });
  }

  _clickFunOK() {
    Navigator.pop(context);
  }

  Widget getColumn(
      String leftLabel, String left, String rightLabel, String right) {
    return new Container(
      margin: new EdgeInsets.only(left: 5.0),
      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
      //color: RLZZColors.mainColor,
      //height: 25.0,
      child: new Row(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            width: width * 0.4,
            child: Text(
              leftLabel + (left ?? ''),
              style: TextStyle(
                fontSize: SetConstants.normalTextSize,
              ),
              //color: Colors.white),
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            width: width * 0.4,
            child: Text(
              rightLabel + (right ?? ''),
              style: TextStyle(
                fontSize: SetConstants.normalTextSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context) * 0.6;

    ///操作按钮
    List<Widget> btnList = new List();

    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.mainColor,
      text: StringZh.app_close,
      fontColor: Colors.white,
      clickFun: () {
        _clickFunOK();
      },
    ));

    Widget mainWidget = new Column(
      children: <Widget>[
        getColumn(
            '${StringZh.docNo}：', vo.docNo, '${StringZh.docNo}：', vo.docDate),
        getColumn('${StringZh.customer}：', vo.customerName,
            '${StringZh.rowNo}：', vo.rowNo),
        getColumn('${StringZh.invCode}：', vo.invCode, '${StringZh.invName}：',
            vo.invName),
        getColumn(
            '${StringZh.invSpec}：', vo.invSpec, '${StringZh.qty}：', vo.qty),
        getColumn('${StringZh.mainUnit}：', vo.mainUnit,
            '${StringZh.batchNumber}：', vo.batchNumber),
        getColumn('${StringZh.startDate}：', vo.startDate,
            '${StringZh.completionDate}：', vo.completionDate),
        getColumn('${StringZh.followNumber}：', vo.followNumber,
            '${StringZh.remark}：', vo.remark),
        new Container(
          margin: new EdgeInsets.only(left: 5.0),
          child: new Row(
            children: <Widget>[
              new Text(
                '${StringZh.head_attachment}：',
                style: new TextStyle(
                  fontSize: SetConstants.normalTextSize,
                ),
              ),
              WidgetUtil.getFileWidget(context, vo.enclosure),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 5.0),
          child: new Row(
            children: <Widget>[
              new Text(
                '${StringZh.body_attachment}：',
                style: new TextStyle(
                  fontSize: SetConstants.normalTextSize,
                ),
              ),
              WidgetUtil.getFileWidget(context, vo.bodyEnclosure),
            ],
          ),
        ),
      ],
    );
    return new DialogPage(
      title: StringZh.productionOrderDetail_title,
      mainWidget: mainWidget,
      btnList: btnList,
      widthProportion: 0.6,
      heightProportion: 0.7,
    );
  }
}
