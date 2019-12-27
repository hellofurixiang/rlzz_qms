import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/page/RefPage.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';
import 'package:qms/widget/UploadImageWidget.dart';

///检验单详情
class TestOrderSampleHeadInfoPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///新增状态
  final bool isAdd;

  ///审核状态
  final bool auditStatus;

  TestOrderSampleHeadInfoPage({
    Key key,
    @required this.testOrderInfo,
    @required this.isAdd,
    @required this.auditStatus,
  }) : super(key: key);

  @override
  TestOrderSampleHeadInfoPageState createState() =>
      new TestOrderSampleHeadInfoPageState();
}

class TestOrderSampleHeadInfoPageState
    extends State<TestOrderSampleHeadInfoPage> {
  double width;

  ///检验结果
  List<DropdownMenuItem> resultItems = [];

  ///合格数量输入框控制器
  TextEditingController qualifiedQtyController = new TextEditingController();

  ///不良数量输入框控制器
  TextEditingController unQualifiedQtyController = new TextEditingController();

  ///不良说明输入框控制器
  TextEditingController badReasonInfoController = new TextEditingController();

  ///返工数量
  TextEditingController reworkQtyController = new TextEditingController();

  ///特采数量
  TextEditingController spQtyController = new TextEditingController();

  ///报废数量
  TextEditingController scrapQtyController = new TextEditingController();

  ///让步接收数
  TextEditingController concessionReceivedQtyController =
      new TextEditingController();

  ///一般缺陷
  TextEditingController generalDefectsQtyController =
      new TextEditingController();

  ///主要缺陷
  TextEditingController majorDefectsQtyController = new TextEditingController();

  ///严重数量
  TextEditingController seriousDefectsQtyController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    resultItems =
        Config.testResult.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    _setDetailControllerInfo();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///修改输入框
  _setDetailControllerInfo() {
    ///不良数量
    getQtyInfo(unQualifiedQtyController, widget.testOrderInfo.unQualifiedQty);

    ///合格数量
    getQtyInfo(qualifiedQtyController, widget.testOrderInfo.qualifiedQty);

    ///返工数量
    getQtyInfo(reworkQtyController, widget.testOrderInfo.reworkQty);

    ///特采数量
    getQtyInfo(spQtyController, widget.testOrderInfo.spQty);

    ///报废数量
    getQtyInfo(scrapQtyController, widget.testOrderInfo.scrapQty);

    ///让步接收数
    getQtyInfo(concessionReceivedQtyController,
        widget.testOrderInfo.concessionReceivedQuantity);

    ///一般缺陷数
    getQtyInfo(
        generalDefectsQtyController, widget.testOrderInfo.generalDefectsQty);

    ///主要缺陷数
    getQtyInfo(majorDefectsQtyController, widget.testOrderInfo.majorDefectsQty);

    ///严重缺陷数
    getQtyInfo(
        seriousDefectsQtyController, widget.testOrderInfo.seriousDefectsQty);
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
              new Container(
                width: 90.0,
                //height: 40.0,
                alignment: Alignment.center,
                color: SetColors.twoLevel,
                margin: new EdgeInsets.only(top: 2.0, bottom: 2.0),
                padding: new EdgeInsets.only(left: 5.0),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    items: resultItems,
                    onChanged: (value) {
                      setState(() {
                        widget.testOrderInfo.testResult = value;
                      });
                    },
                    value: widget.testOrderInfo.testResult,
                    //hint: new Text(StringZh.prompt_sob),
                    style: new TextStyle(
                        fontSize: SetConstants.normalTextSize,
                        color: Colors.black),
                    //iconEnabledColor: Colors.white,
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
                width: 70.0,
                child: new Text(
                  StringZh.qualifiedQty,
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
                    double unQualifiedQty = CommonUtil.getDoubleValue(v);
                    if (unQualifiedQty > widget.testOrderInfo.quantity) {
                      Fluttertoast.showToast(
                          msg: StringZh
                              .tip_unQualifiedQty_not_greater_than_shouldQty);
                      unQualifiedQtyController.text =
                          widget.testOrderInfo.unQualifiedQty.toString();
                      return;
                    }
                    double quantity = widget.testOrderInfo.quantity;
                    double concessionReceivedQty = CommonUtil.getDoubleValue(
                        concessionReceivedQtyController.text);

                    double qualifiedQty =
                        quantity - concessionReceivedQty - unQualifiedQty;

                    widget.testOrderInfo.unQualifiedQty = unQualifiedQty;
                    qualifiedQtyController.text = qualifiedQty.toString();
                    widget.testOrderInfo.qualifiedQty = qualifiedQty;
                    print(
                        "quantity -> $quantity - unQualifiedQty -> $unQualifiedQty - concessionReceivedQty -> $concessionReceivedQty = qualifiedQty -> $qualifiedQty");
                  },
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
                      color: SetColors.red),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: reworkQtyController,
                  onChanged: (v) {
                    ///返工数量
                    double reworkQty = CommonUtil.getDoubleValue(v);

                    ///不良数量
                    double unQualifiedQty = widget.testOrderInfo.unQualifiedQty;

                    ///特采数量
                    double spQty = widget.testOrderInfo.spQty;

                    ///报废数量
                    //double scrapQty = widget.testOrderInfo.scrapQty;

                    if (reworkQty + spQty > unQualifiedQty) {
                      Fluttertoast.showToast(
                          msg: StringZh
                              .tip_spQty_and_reworkQty_not_greater_than_unQualifiedQty);

                      reworkQtyController.text =
                          widget.testOrderInfo.reworkQty.toString();
                      return;
                    }

                    ///报废数量
                    double scrapQty = unQualifiedQty - spQty - reworkQty;

                    scrapQtyController.text = scrapQty.toString();

                    widget.testOrderInfo.reworkQty = reworkQty;

                    print(
                        "unQualifiedQty -> $unQualifiedQty - spQty -> $spQty - scrapQty -> $scrapQty = scrapQty -> $scrapQty");
                  },
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
                  StringZh.concessionReceivedQty,
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 150.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: concessionReceivedQtyController,
                  onChanged: (v) {
                    double quantity = widget.testOrderInfo.quantity;

                    double concessionReceivedQty = CommonUtil.getDoubleValue(v);

                    if (concessionReceivedQty > widget.testOrderInfo.quantity) {
                      Fluttertoast.showToast(
                          msg: StringZh
                              .tip_concessionReceivedQty_not_greater_than_shouldQty);
                      concessionReceivedQtyController.text = widget
                          .testOrderInfo.concessionReceivedQuantity
                          .toString();
                      return;
                    }

                    double unQualifiedQty = CommonUtil.getDoubleValue(
                        unQualifiedQtyController.text);

                    double qualifiedQty =
                        quantity - concessionReceivedQty - unQualifiedQty;

                    qualifiedQtyController.text = qualifiedQty.toString();

                    widget.testOrderInfo.qualifiedQty = qualifiedQty;
                    widget.testOrderInfo.concessionReceivedQuantity =
                        concessionReceivedQty;
                    print(
                        "quantity -> $quantity - unQualifiedQty -> $unQualifiedQty - concessionReceivedQty -> $concessionReceivedQty = qualifiedQty -> $qualifiedQty");
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.spQty,
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
                  controller: spQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.spQty = CommonUtil.getDoubleValue(v);
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.scrapQty,
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
                  controller: scrapQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.scrapQty =
                        CommonUtil.getDoubleValue(v);
                  },
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
                  StringZh.seriousDefectsQty,
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
                  isNumber: true,
                  controller: seriousDefectsQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.seriousDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.majorDefectsQty,
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
                  isNumber: true,
                  controller: majorDefectsQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.majorDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  StringZh.generalDefectsQty,
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
                  isNumber: true,
                  controller: generalDefectsQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.generalDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
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
                      margin: new EdgeInsets.only(left: 5.0, right: 5.0),
                      width: 70.0,
                      child: new Text(
                        StringZh.text_badReason,
                        style: new TextStyle(
                            fontSize: SetConstants.normalTextSize,
                            color: Colors.black),
                      ),
                    ),
                    new TextWidget(
                      height: 30.0,
                      width: 150.0,
                      text: widget.testOrderInfo.badReasonName,
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
                            color: Colors.black),
                      ),
                    ),
                    new Container(
                      height: 30.0,
                      width: 150.0,
                      child: new InputWidget(
                        controller: badReasonInfoController,
                        onChanged: (v) {
                          widget.testOrderInfo.badReasonInfo = v;
                        },
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
          child: new Row(
            children: <Widget>[
              new Text(
                StringZh.tip_unQualifiedQty_reworkQty_spQty_scrapQty,
                style: new TextStyle(
                    fontSize: SetConstants.smallTextSize, color: Colors.red),
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
            widget.testOrderInfo.enclosure,
            widget.testOrderInfo.badEnclosureList,
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
            url: Config.qmsApiUrl + Config.badReasonRefUrl,
            arcCode: widget.testOrderInfo.badReasonCode,
            okFun: (obj) {
              setState(() {
                widget.testOrderInfo
                  ..badReasonCode = obj['arcCode']
                  ..badReasonName = obj['arcName'];
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
