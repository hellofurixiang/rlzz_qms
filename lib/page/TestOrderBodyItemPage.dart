import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/BadReasonRefPage.dart';
import 'package:qms/page/FileListPage.dart';
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
    this.testOrderInfo,
    this.testOrderDetailList,
    this.cacheInfo,
    this.isAdd,
    this.auditStatus,
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
          color: RLZZColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Text(
                '检验描述',
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize, color: Colors.black),
              ),
              new Expanded(child: new Container()),
              new Text(
                '检验方法：' + (widget.cacheInfo.testMethodName ?? ''),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 10.0),
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '检验方式：' + (widget.cacheInfo.testWay ?? ''),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              new Text(
                '抽检方式：' + (widget.cacheInfo.samplingWay ?? ''),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              new Text(
                '应检数量：' + widget.cacheInfo.quantity.toString(),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '标准值：' + widget.cacheInfo.standardValue.toString(),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              new Text(
                '上限：' + widget.cacheInfo.upperLimitValue.toString(),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              new Text(
                '下限：' + widget.cacheInfo.lowerLimitValue.toString(),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              new Text(
                '指标类型：' + widget.cacheInfo.quotaCat,
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '检验描述：' + (widget.cacheInfo.testDecription ?? ''),
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Text(
                '相关附件：',
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize,
                    color: RLZZColors.darkDarkGrey),
              ),
              getFileWidget(widget.cacheInfo.enclosure),
            ],
          ),
        ),
        new Container(
          height: 30.0,
          margin: new EdgeInsets.only(top: 10.0),
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                '检验结果',
                style: new TextStyle(
                    fontSize: RLZZConstant.middleTextSize, color: Colors.black),
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
                  '合格数量',
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.darkDarkGrey),
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
                  '不良数量',
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.red),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: unQualifiedQtyController,
                  onChanged: (v) {
                    print('不良数量:' + v);
                    if ('' == v.trim()) {
                      widget.cacheInfo.unQualifiedQty = double.parse('0');
                      widget.cacheInfo.qualifiedQty = widget.cacheInfo.quantity;
                      qualifiedQtyController.text =
                          widget.cacheInfo.qualifiedQty.toString();
                    } else {
                      double unQualifiedQty = double.parse(v);
                      if (unQualifiedQty > widget.cacheInfo.quantity) {
                        Fluttertoast.showToast(msg: '不良数量不能大于应检数量');
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
                  '测量值',
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.darkDarkGrey),
                ),
              ),
              new TextWidget(
                height: 30.0,
                width: 150.0,
                text: widget.cacheInfo.testQtyInfo,
                onTapFun: () {
                  if (null != widget.cacheInfo.testQtyInfo) {
                    WidgetUtil.showRemark(context,
                        remark: widget.cacheInfo.testQtyInfo);
                  }
                },
                iconWidget: new GestureDetector(
                  onTap: () {
                    ///测量值列表页面
                    showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          if (Config.quotaTypeEnum ==
                              widget.cacheInfo.quotaCat) {
                            return new TestValueEnumListPage(
                              testOrderDetailId: widget.cacheInfo.id,
                              qty: widget.cacheInfo.quantity,
                              testQuotaCode: widget.cacheInfo.testQuotaCode,
                              valueList: widget.cacheInfo.testQtyInfoDetailList,
                              standardValue: widget.cacheInfo.standardValue,
                              okFun: (String testQtyInfo, List valueList) {
                                widget.cacheInfo.testQtyInfoDetailList =
                                    valueList;
                                setState(() {
                                  widget.cacheInfo.testQtyInfo = testQtyInfo;
                                });
                              },
                            );
                          }
                          return new TestValueListPage(
                            testOrderDetailId: widget.cacheInfo.id,
                            qty: widget.cacheInfo.quantity,
                            quotaCat: widget.cacheInfo.quotaCat,
                            standardValue: widget.cacheInfo.standardValue,
                            valueList: widget.cacheInfo.testQtyInfoDetailList,
                            okFun: (String testQtyInfo, List valueList) {
                              widget.cacheInfo.testQtyInfoDetailList =
                                  valueList;
                              setState(() {
                                widget.cacheInfo.testQtyInfo = testQtyInfo;
                              });
                            },
                          );
                        });
                  },
                  child: new Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: RLZZColors.mainColor,
                    ),
                    margin: new EdgeInsets.only(left: 6.0),
                    padding: new EdgeInsets.only(
                        top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
                    child: new Text(
                      '样',
                      style: TextStyle(
                          fontSize: RLZZConstant.smallTextSize,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                        '不良原因',
                        style: new TextStyle(
                            fontSize: RLZZConstant.normalTextSize,
                            color: RLZZColors.darkDarkGrey),
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
                            color: RLZZColors.darkDarkGrey,
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
                        '不良说明',
                        style: new TextStyle(
                            fontSize: RLZZConstant.normalTextSize,
                            color: RLZZColors.darkDarkGrey),
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
                          '操作者',
                          style: new TextStyle(
                              fontSize: RLZZConstant.normalTextSize,
                              color: RLZZColors.darkDarkGrey),
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
          color: RLZZColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Text(
                '图像附件',
                style: new TextStyle(
                    fontSize: RLZZConstant.normalTextSize, color: Colors.black),
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

  ///查看文件
  Widget getFileWidget(String enclosure) {
    bool bo = false;
    if (CommonUtil.isEmpty(enclosure)) {
      bo = true;
    }
    return new GestureDetector(
      onTap: () {
        if (bo) {
          return;
        }
        List<Enclosure> enclosureList = [];

        List arr = json.decode(enclosure.replaceAll('\'', '"'));
        arr.forEach((f) {
          enclosureList.add(Enclosure.fromJson(f));
        });
        showDialog<Null>(
            context: context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new FileListPage(enclosureList);
            });
      },
      child: new Container(
        height: 25.0,
        alignment: Alignment.center,
        padding: new EdgeInsets.all(2.0),
        child: new Text(
          '查看附件',
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: RLZZConstant.smallTextSize,
              color: bo ? RLZZColors.lightLightGrey : RLZZColors.mainColor,
              decoration: bo ? TextDecoration.none : TextDecoration.underline),
        ),
        //decoration: boxDecoration,
      ),
    );
  }

  ///获取不良原因
  void getReasonInfoModel() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new BadReasonRefPage(
            okFun: (obj) {
              setState(() {
                widget.cacheInfo.badReasonCode = obj['arcCode'];
                widget.cacheInfo.badReasonName = obj['arcName'];
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
