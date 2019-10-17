import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/TestOrderPage.dart';
import 'package:qms/page/TestOrderSamplePage.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';
import 'package:qms/widget/InputWidget.dart';

///选择检验模板
class TestTemplateSelectPage extends StatefulWidget {
  ///数量
  final String qty;

  ///检验类型
  final String testCat;

  ///单据类型
  final String docCat;

  ///物料分类编码
  final String invCatCode;

  ///物料编码
  final String invCode;

  ///工序编码
  final String opCode;

  ///来源单据详情ID
  final String srcDocDetailId;

  ///单据标题
  final String detailTitle;

  TestTemplateSelectPage({
    Key key,
    @required this.qty,
    @required this.docCat,
    @required this.testCat,
    @required this.invCatCode,
    @required this.invCode,
    this.opCode,
    @required this.srcDocDetailId,
    @required this.detailTitle,
  }) : super(key: key);

  @override
  TestTemplateSelectPageState createState() => TestTemplateSelectPageState();
}

class TestTemplateSelectPageState extends State<TestTemplateSelectPage> {
  @override
  initState() {
    super.initState();
    qtyEc.text = widget.qty.toString();
    _getDataRequest();
  }

  @override
  dispose() {
    super.dispose();
    qtyEc.dispose();
  }

  ///页面宽度
  double width;

  ///数量输入框控制器
  TextEditingController qtyEc = new TextEditingController();

  ///数据列表
  List dataList = new List();

  bool loading = true;

  ///初始化数据
  void _getDataRequest() {
    QmsService.getTestTemplate(context, {
      'docCat': widget.docCat,
      'testCat': widget.testCat,
      'invCatCode': widget.invCatCode,
      'invCode': widget.invCode,
      'opCode': widget.opCode,
    }, (res) {
      if (res.length == 1) {
        res[0]['isSelect'] = true;
      }
      setState(() {
        dataList = res;
        loading = false;
      });
    }, (err) {
      setState(() {
        loading = false;
      });
    });
  }

  _clickFunOK() {
    String testTemplateId;
    String testTemplateName = '';
    String testRule = '';
    for (int i = 0; i < dataList.length; i++) {
      var v = dataList[i];
      if (null != v['isSelect'] && v['isSelect']) {
        testTemplateId = v['id'].toString();
        testTemplateName = v['arcName'];
        testRule = v['testRule'];
        break;
      }
    }

    if (null == testTemplateId) {
      Fluttertoast.showToast(
          msg: StringZh.tip_selectTestTemplate, timeInSecForIos: 3);
      return;
    }
    if ('' == qtyEc.text.trim() ||
        double.parse(qtyEc.text) > double.parse(widget.qty)) {
      Fluttertoast.showToast(msg: '请输入正确的报检数量', timeInSecForIos: 3);
      return;
    }
    Navigator.pop(context);

    String testOrderType = '';
    String docCat = widget.docCat;
    String testCat = widget.testCat;

    ///单据标题
    String detailTitle = widget.detailTitle;

    switch (widget.docCat) {
      case Config.test_order_arrival:
        if (testRule == Config.testForInv) {
          detailTitle = StringZh.arrivalTestOrderSampleDetail_title;
          testOrderType = 'sample';
          docCat = Config.test_order_arrival_sample;
        }
        break;
      case Config.test_order_complete:
        if (testRule == Config.testForInv) {
          detailTitle = StringZh.completeTestOrderSampleDetail_title;
          testOrderType = 'sample';
          docCat = Config.test_order_complete_sample;
        }
        break;

      /*case Config.test_order_iqc:
        break;
      case Config.test_order_fqc:

        break;*/

      case Config.test_order_ipqc:
      case Config.test_order_pqc:
        testOrderType = 'sample';
        break;
      default:
        break;
    }
    if (testOrderType == 'sample') {
      NavigatorUtil.goToPage(
          context,
          new TestOrderSamplePage(
            docCat: docCat,
            testCat: testCat,
            qty: qtyEc.text,
            srcDocDetailId: widget.srcDocDetailId,
            testTemplateId: testTemplateId,
            testTemplateName: testTemplateName,
            invCatCode: widget.invCatCode,
            title: detailTitle,
          ));
    } else {
      NavigatorUtil.goToPage(
          context,
          new TestOrderPage(
            docCat: docCat,
            testCat: testCat,
            qty: qtyEc.text,
            srcDocDetailId: widget.srcDocDetailId,
            testTemplateId: testTemplateId,
            testTemplateName: testTemplateName,
            invCatCode: widget.invCatCode,
            title: detailTitle,
          ));
    }
  }

  _renderItem(int index) {
    var data = dataList[index];

    bool isSelect = false;

    if (null != data['isSelect'] && data['isSelect']) {
      isSelect = true;
    }

    Widget indexWidget = Container(
      width: 25.0,
      //padding: EdgeInsets.only(left: 3.0),
      alignment: Alignment.center,
      child: Icon(
        isSelect ? Icons.check_box : Icons.check_box_outline_blank,
        color: RLZZColors.mainColor,
        size: 20.0,
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          bottom: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
        ),
      ),
    );

    List<Widget> widgetList = new List();
    widgetList.add(Container(
      alignment: Alignment.center,
      width: width * 0.5 * 0.3,
      child: Text(
        data['arcCode'],
        style: TextStyle(fontSize: RLZZConstant.normalTextSize),
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          left: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
        ),
      ),
    ));
    widgetList.add(Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          data['arcName'],
          style: TextStyle(fontSize: RLZZConstant.normalTextSize),
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            right: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
            left: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
          ),
        ),
      ),
    ));
    widgetList.add(Container(
      alignment: Alignment.center,
      width: width * 0.5 * 0.2,
      child: Text(
        data['testRule'] ?? '',
        style: TextStyle(fontSize: RLZZConstant.normalTextSize),
      ),
    ));
    /*if (null != data['isSelect'] && data['isSelect']) {
      widgetList.add(Container(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.done,
          color: RLZZColors.mainColor,
          size: 20.0,
        ),
      ));
    }*/

    return GestureDetector(
      onTap: () {
        setState(() {
          dataList.forEach((v) {
            v['isSelect'] = false;
          });
          data['isSelect'] = true;
        });
      },
      child: Container(
          height: 30.0,
          //padding: new EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              indexWidget,
              Expanded(
                child: Container(
                  child: Row(
                    children: widgetList,
                  ),
                ),
              ),
            ],
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
              bottom: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);

    ///操作按钮
    List<Widget> btnList = new List();
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.darkGrey,
      text: StringZh.app_cancel,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));

    if (dataList.length != 0) {
      btnList.add(ButtonWidget(
        height: 30.0,
        width: 65.0,
        backgroundColor: RLZZColors.mainColor,
        text: StringZh.app_ok,
        fontColor: Colors.white,
        clickFun: () {
          _clickFunOK();
        },
      ));
    }

    Widget mainWidget = new Column(
      children: <Widget>[
        Container(
          margin: new EdgeInsets.only(
            left: 5.0,
          ),
          height: 35.0,
          alignment: Alignment.centerLeft,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 80.0,
                child: new Text(StringZh.selectTestTemplate_testQty),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  controller: qtyEc,
                  isNumber: true,
                  enabled: widget.docCat != Config.test_order_ipqc,
                ),
              ),
            ],
          ),
        ),
        new Container(
          //padding: new EdgeInsets.all(2.0),
          color: RLZZColors.mainColor,
          height: 25.0,
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                width: 25.0,
              ),
              new Container(
                alignment: Alignment.center,
                width: width * 0.5 * 0.3,
                child: Text(
                  '编码',
                  style: TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: RLZZColors.mainColor,
                  border: new Border(
                    left:
                        new BorderSide(color: RLZZColors.darkGrey, width: 1.0),
                  ),
                ),
              ),
              new Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '名称',
                    style: TextStyle(
                        fontSize: RLZZConstant.normalTextSize,
                        color: Colors.white),
                  ),
                  decoration: new BoxDecoration(
                    color: RLZZColors.mainColor,
                    border: new Border(
                      right: new BorderSide(
                          color: RLZZColors.darkGrey, width: 1.0),
                      left: new BorderSide(
                          color: RLZZColors.darkGrey, width: 1.0),
                    ),
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.center,
                width: width * 0.5 * 0.2,
                child: Text(
                  '检验规则',
                  style: TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        new Expanded(
          child: loading
              ? WidgetUtil.getLoadingWidget(StringZh.loading)
              : new Container(
                  child: dataList.length == 0
                      ? WidgetUtil.buildEmptyToList(context,
                          onRefresh: _getDataRequest)
                      : new ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              _renderItem(index),
                          itemCount: dataList.length,
                        ),
                ),
        ),
      ],
    );

    return new DialogPage(
      title: StringZh.selectTestTemplate,
      mainWidget: mainWidget,
      btnList: btnList,
    );
  }
}
