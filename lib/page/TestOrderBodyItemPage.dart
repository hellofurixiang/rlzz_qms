import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/RefPage.dart';
import 'package:qms/page/TestValueEnumListPage.dart';
import 'package:qms/page/TestValueListPage.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';
import 'package:qms/widget/UploadImageWidget.dart';

///检验单表体详情
class TestOrderBodyItemPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///检验单表体
  final List<TestOrderDetail> testOrderDetailList;

  ///缓存数据
  final TestOrderDetail cacheInfo;

  ///新增状态
  final bool isAdd;

  ///审核状态
  final bool auditStatus;

  TestOrderBodyItemPage({
    Key key,
    @required this.testOrderInfo,
    @required this.testOrderDetailList,
    @required this.cacheInfo,
    @required this.isAdd,
    @required this.auditStatus,
  }) : super(key: key);

  @override
  TestOrderBodyItemPageState createState() => new TestOrderBodyItemPageState();
}

class TestOrderBodyItemPageState extends State<TestOrderBodyItemPage> {
  double width;

  ///合格数量输入框控制器
  TextEditingController qualifiedQtyController = new TextEditingController();

  ///不良数量输入框控制器
  TextEditingController unQualifiedQtyController = new TextEditingController();

  ///不良说明输入框控制器
  TextEditingController badReasonInfoController = new TextEditingController();

  ///操作者
  TextEditingController producerController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    ///修改输入框
    _setDetailControllerInfo();
  }

  @override
  void didUpdateWidget(TestOrderBodyItemPage oldWidget) {
    //print('组件状态改变：didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    _setDetailControllerInfo();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///修改输入框
  _setDetailControllerInfo() {
    badReasonInfoController.text = widget.cacheInfo.badReasonInfo ?? '';
    producerController.text = widget.cacheInfo.producer ?? '';

    getQtyInfo(unQualifiedQtyController, widget.cacheInfo.unQualifiedQty);
    getQtyInfo(qualifiedQtyController, widget.cacheInfo.qualifiedQty);
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
              new Text(
                StringZh.testDescribe,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize, color: Colors.black),
              ),
              new Expanded(child: new Container()),
              new Text(
                '${StringZh.testMethod}：' +
                    (widget.cacheInfo.testMethodName ?? ''),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 10.0),
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '${StringZh.testWay}：' + (widget.cacheInfo.testWay ?? ''),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              new Text(
                '${StringZh.samplingWay}：' +
                    (widget.cacheInfo.samplingWay ?? ''),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              new Text(
                '${StringZh.shouldQty}：' +
                    CommonUtil.getVal(widget.cacheInfo.quantity),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '${StringZh.standardValue}：' +
                    CommonUtil.getVal(widget.cacheInfo.standardValue),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              new Text(
                '${StringZh.lowerLimitValue}：' +
                    CommonUtil.getVal(widget.cacheInfo.lowerLimitValue),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              new Text(
                '${StringZh.upperLimitValue}：' +
                    CommonUtil.getVal(widget.cacheInfo.upperLimitValue),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              new Text(
                '${StringZh.quotaCat}：' + (widget.cacheInfo.quotaCat ?? ''),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '${StringZh.testDescribe}：' +
                    (widget.cacheInfo.testDecription ?? ''),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Text(
                '${StringZh.relatedAttachment}：',
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
              WidgetUtil.getFileWidget(context, widget.cacheInfo.enclosure),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          margin: new EdgeInsets.only(top: 10.0),
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                StringZh.testResult,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize, color: Colors.black),
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
                margin: EdgeInsets.only(right: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.qualifiedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.darkDarkGrey),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  enabled: false,
                  controller: qualifiedQtyController,
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.unQualifiedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.red),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: unQualifiedQtyController,
                  onChanged: (v) {
                    if ('' == v.trim()) {
                      widget.cacheInfo.unQualifiedQty = double.parse('0');
                      widget.cacheInfo.qualifiedQty = widget.cacheInfo.quantity;
                      qualifiedQtyController.text =
                          widget.cacheInfo.qualifiedQty.toString();
                    } else {
                      double unQualifiedQty = double.parse(v);
                      if (unQualifiedQty > widget.cacheInfo.quantity) {
                        Fluttertoast.showToast(
                            msg: StringZh
                                .tip_unQualifiedQty_not_greater_than_shouldQty);
                        unQualifiedQtyController.text = '';
                        qualifiedQtyController.text =
                            widget.cacheInfo.quantity.toString();
                        return;
                      }
                      widget.cacheInfo.unQualifiedQty = double.parse(v);

                      widget.cacheInfo.qualifiedQty =
                          widget.cacheInfo.quantity -
                              widget.cacheInfo.unQualifiedQty;
                      qualifiedQtyController.text =
                          widget.cacheInfo.qualifiedQty.toString();
                    }
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.testVal,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: SetColors.darkDarkGrey),
                ),
              ),
              new TextWidget(
                height: 30.0,
                width: 150.0,
                text: widget.cacheInfo.testQtyInfo ?? '',
                onTapFun: () {
                  if (null != widget.cacheInfo.testQtyInfo) {
                    WidgetUtil.showRemark(context,
                        remark: widget.cacheInfo.testQtyInfo);
                  }
                },
                iconWidget: new GestureDetector(
                  onTap: () {
                    showTestValueDialog();
                  },
                  child: new Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: SetColors.mainColor,
                    ),
                    margin: new EdgeInsets.only(left: 6.0),
                    padding: new EdgeInsets.only(
                        top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
                    child: new Text(
                      StringZh.sample,
                      style: TextStyle(
                          fontSize: SetConstants.smallTextSize,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        getMeasuringToolWidget(),
        new Container(
          child: new Row(
            children: <Widget>[
              new Container(
                height: 30.0,
                margin: new EdgeInsets.only(top: 10.0),
                //padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.centerRight,
                      margin: new EdgeInsets.only(right: 5.0),
                      width: 60.0,
                      child: new Text(
                        StringZh.text_badReason,
                        style: new TextStyle(
                            fontSize: SetConstants.normalTextSize,
                            color: SetColors.darkDarkGrey),
                      ),
                    ),
                    new TextWidget(
                      height: 30.0,
                      width: 150.0,
                      text: widget.cacheInfo.badReasonName,
                      onTapFun: getReasonInfoModel,
                      iconWidget: new GestureDetector(
                        onTap: getReasonInfoModel,
                        child: new Container(
                          alignment: Alignment.center,
                          margin: new EdgeInsets.all(2.0),
                          child: new Icon(
                            Icons.search,
                            size: 22.0,
                            color: SetColors.darkDarkGrey,
                          ),
                        ),
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
                      width: 60.0,
                      child: new Text(
                        StringZh.badReasonInfo,
                        style: new TextStyle(
                            fontSize: SetConstants.normalTextSize,
                            color: SetColors.darkDarkGrey),
                      ),
                    ),
                    new Container(
                      height: 30.0,
                      width: 150.0,
                      child: new InputWidget(
                        controller: badReasonInfoController,
                        onChanged: (v) {
                          widget.cacheInfo.badReasonInfo = v;
                        },
                      ),
                    ),
                    new Offstage(
                      offstage: widget.testOrderInfo.docCat !=
                          Config.test_order_complete,
                      child: new Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 5.0, left: 5.0),
                        width: 60.0,
                        child: new Text(
                          StringZh.producer,
                          style: new TextStyle(
                              fontSize: SetConstants.normalTextSize,
                              color: SetColors.darkDarkGrey),
                        ),
                      ),
                    ),
                    new Offstage(
                      offstage: widget.testOrderInfo.docCat !=
                          Config.test_order_complete,
                      child: new Container(
                        height: 30.0,
                        width: 150.0,
                        child: new InputWidget(
                          controller: producerController,
                          onChanged: (v) {
                            widget.cacheInfo.producer = v;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          margin: new EdgeInsets.only(top: 10.0),
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Text(
                StringZh.imageAttachment,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize, color: Colors.black),
              ),
            ],
          ),
        ),
        new UploadImageWidget(
            widget.cacheInfo.badPictures,
            widget.cacheInfo.badEnclosureList,
            _getSelectImageWidgetBo(),
            150.0),
      ],
    );
  }

  ///获取不良原因
  void getReasonInfoModel() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new RefPage(
            title: StringZh.text_badReason,
            url: Config.badReasonRefUrl,
            arcCode: widget.cacheInfo.badReasonCode,
            okFun: (obj) {
              setState(() {
                widget.cacheInfo.badReasonCode = obj['arcCode'];
                widget.cacheInfo.badReasonName = obj['arcName'];
              });
            },
          );
        });
  }

  void showTestValueDialog() {
    ///测量值列表页面
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (Config.quotaTypeEnum == widget.cacheInfo.quotaCat) {
            return new TestValueEnumListPage(
              testOrderDetailId: widget.cacheInfo.id,
              qty: widget.cacheInfo.quantity,
              testQuotaCode: widget.cacheInfo.testQuotaCode,
              valueList: widget.cacheInfo.testQtyInfoDetailList,
              standardValue: widget.cacheInfo.standardValue,
              okFun: (String testQtyInfo, List valueList) {
                widget.cacheInfo.testQtyInfoDetailList = valueList;
                setState(() {
                  widget.cacheInfo.testQtyInfo = testQtyInfo;
                });
              },
            );
          }
          return new TestValueListPage(
            testOrderDetailId: widget.cacheInfo.id,
            docCat: widget.testOrderInfo.docCat,
            qty: widget.cacheInfo.quantity,
            quotaCat: widget.cacheInfo.quotaCat,
            standardValue: widget.cacheInfo.standardValue,
            valueList: widget.cacheInfo.testQtyInfoDetailList,
            okFun: (String testQtyInfo, List valueList) {
              widget.cacheInfo.testQtyInfoDetailList = valueList;
              setState(() {
                widget.cacheInfo.testQtyInfo = testQtyInfo;
              });
            },
          );
        });
  }

  Widget getMeasuringToolWidget() {
    if (widget.testOrderInfo.docCat == Config.test_order_iqc ||
        widget.testOrderInfo.docCat == Config.test_order_fqc) {
      return new Container(
        height: 30.0,
        margin: new EdgeInsets.only(top: 10.0),
        //padding: new EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              alignment: Alignment.centerRight,
              margin: new EdgeInsets.only(right: 5.0),
              width: 60.0,
              child: new Text(
                StringZh.unitName,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ),
            new Container(
              height: 30.0,
              width: 150.0,
              child: new InputWidget(
                enabled: false,
                initText: widget.cacheInfo.unitName ?? '',
              ),
            ),
            new Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 5.0, left: 5.0),
              width: 60.0,
              child: new Text(
                StringZh.measuringTool,
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize,
                    color: SetColors.darkDarkGrey),
              ),
            ),
            new TextWidget(
              height: 30.0,
              width: 150.0,
              text: widget.cacheInfo.measuringToolName,
              onTapFun: getMeasuringToolModel,
              iconWidget: new GestureDetector(
                onTap: getMeasuringToolModel,
                child: new Container(
                  alignment: Alignment.center,
                  margin: new EdgeInsets.all(2.0),
                  child: new Icon(
                    Icons.search,
                    size: 22.0,
                    color: SetColors.darkDarkGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return new Container();
    }
  }

  ///获取测量工具
  void getMeasuringToolModel() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new RefPage(
            title: StringZh.test_measuringTool,
            url: Config.measuringToolRefUrl,
            arcCode: widget.cacheInfo.measuringToolCode,
            okFun: (obj) {
              setState(() {
                widget.cacheInfo.measuringToolCode = obj['arcCode'];
                widget.cacheInfo.measuringToolName = obj['arcName'];
              });
            },
          );
        });
  }

  ///配置选择图片按钮
  bool _getSelectImageWidgetBo() {
    if (!widget.isAdd) {
      return !widget.auditStatus;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);

    return _getDetailInfo();
  }
}
