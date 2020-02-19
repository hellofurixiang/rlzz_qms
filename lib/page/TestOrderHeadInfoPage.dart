import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/DataModel.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/page/BadInfoListPage.dart';
import 'package:qms/page/SignPage.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';
import 'package:qms/widget/UploadImageWidget.dart';

///检验单详情
class TestOrderHeadInfoPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///新增状态
  final bool isAdd;

  ///审核状态
  final bool auditStatus;

  TestOrderHeadInfoPage({
    Key key,
    @required this.testOrderInfo,
    @required this.isAdd,
    @required this.auditStatus,
  }) : super(key: key);

  @override
  TestOrderHeadInfoPageState createState() => new TestOrderHeadInfoPageState();
}

class TestOrderHeadInfoPageState extends State<TestOrderHeadInfoPage> {
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

    print(widget.testOrderInfo.docCat);
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///修改输入框
  _setDetailControllerInfo() {
    ///不良数量
    unQualifiedQtyController.text = widget.testOrderInfo.unQualifiedQty == null
        ? ''
        : widget.testOrderInfo.unQualifiedQty.toString();

    ///合格数量
    qualifiedQtyController.text = widget.testOrderInfo.qualifiedQty == null
        ? ''
        : widget.testOrderInfo.qualifiedQty.toString();
    badReasonInfoController.text = widget.testOrderInfo.badReasonInfo ?? '';

    ///返工数量
    reworkQtyController.text = widget.testOrderInfo.reworkQty == null
        ? ''
        : widget.testOrderInfo.reworkQty.toString();

    ///特采数量
    spQtyController.text = widget.testOrderInfo.spQty == null
        ? ''
        : widget.testOrderInfo.spQty.toString();

    ///报废数量
    scrapQtyController.text = widget.testOrderInfo.scrapQty == null
        ? ''
        : widget.testOrderInfo.scrapQty.toString();

    ///让步接收数
    concessionReceivedQtyController.text =
        widget.testOrderInfo.concessionReceivedQuantity == null
            ? ''
            : widget.testOrderInfo.concessionReceivedQuantity.toString();
  }

  double getDoubleValue(String oldVal) {
    if ('' == oldVal.trim()) {
      return 0;
    }

    return double.parse(oldVal.trim());
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
                      color: SetColors.darkDarkGrey),
                ),
              ),
              new Container(
                height: 30.0,
                width: 130.0,
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
                width: 130.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: unQualifiedQtyController,
                  onChanged: (v) {
                    double unQualifiedQty = getDoubleValue(v);
                    if (unQualifiedQty > widget.testOrderInfo.quantity) {
                      Fluttertoast.showToast(
                          msg: StringZh
                              .tip_unQualifiedQty_not_greater_than_shouldQty);
                      unQualifiedQtyController.text =
                          widget.testOrderInfo.unQualifiedQty.toString();
                      return;
                    }
                    double quantity = widget.testOrderInfo.quantity;
                    double concessionReceivedQty =
                        getDoubleValue(concessionReceivedQtyController.text);

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
                width: 130.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: reworkQtyController,
                  onChanged: (v) {
                    ///返工数量
                    double reworkQty = getDoubleValue(v);

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
                      color: SetColors.darkDarkGrey),
                ),
              ),
              new Container(
                height: 30.0,
                width: 130.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: concessionReceivedQtyController,
                  onChanged: (v) {
                    double quantity = widget.testOrderInfo.quantity;

                    double concessionReceivedQty = getDoubleValue(v);

                    if (concessionReceivedQty > widget.testOrderInfo.quantity) {
                      Fluttertoast.showToast(
                          msg: StringZh
                              .tip_concessionReceivedQty_not_greater_than_shouldQty);
                      concessionReceivedQtyController.text = widget
                          .testOrderInfo.concessionReceivedQuantity
                          .toString();
                      return;
                    }

                    double unQualifiedQty =
                        getDoubleValue(unQualifiedQtyController.text);

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
                width: 130.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: spQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.spQty = getDoubleValue(v);
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
                width: 130.0,
                child: new InputWidget(
                  isNumber: true,
                  controller: scrapQtyController,
                  onChanged: (v) {
                    widget.testOrderInfo.scrapQty = getDoubleValue(v);
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
                            color: SetColors.darkDarkGrey),
                      ),
                    ),
                    new TextWidget(
                      height: 30.0,
                      width: 130.0,
                      //text: widget.testOrderInfo.badReasonName,
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
                      width: 130.0,
                      child: new InputWidget(
                        controller: badReasonInfoController,
                        onChanged: (v) {
                          widget.testOrderInfo.badReasonInfo = v;
                        },
                      ),
                    ),
                    new Offstage(
                      offstage: widget.testOrderInfo.docCat !=
                          Config.test_order_complete,
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 5.0, left: 5.0),
                            width: 60.0,
                            child: new Text(
                              StringZh.sign,
                              style: new TextStyle(
                                  fontSize: SetConstants.normalTextSize,
                                  color: SetColors.darkDarkGrey),
                            ),
                          ),
                          showSignImage(),
                          new TextWidget(
                            height: 30.0,
                            width: 60.0,
                            isCenter: true,
                            text: StringZh.sign,
                            onTapFun: getSignature,
                          ),
                        ],
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
            width * 0.75),
      ],
    );
  }

  ///获取不良原因
  void getReasonInfoModel() {
    /*showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new RefPage(url:Config.qmsApiUrl+Config.badReasonRefUrl,
            arcCode: widget.testOrderInfo.badReasonCode,
            okFun: (obj) {
              setState(() {
                widget.testOrderInfo.badReasonCode = obj['arcCode'];
                widget.testOrderInfo.badReasonName = obj['arcName'];
              });
            },
          );
        });*/

    ///测量值列表页面
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new BadInfoListPage(
            testOrderId: widget.testOrderInfo.id,
            unQualifiedQty: widget.testOrderInfo.unQualifiedQty,
            valueList: widget.testOrderInfo.badInfoList,
            okFun: (valueList) {
              widget.testOrderInfo.badInfoList = valueList;
            },
          );
        });
  }

  ///获取签名
  void getSignature() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SignPage(
            uploadSuccessFun: (var obj) {
              Navigator.pop(context);
              setState(() {
                widget.testOrderInfo.signImage.localFile = obj.localFile;

                widget.testOrderInfo.signPic =
                    '{"id":"${obj.id}","name":"${obj.name}","size":"${obj.size}"}';
              });
            },
          );
        });
  }

  ///显示签名图片
  Widget showSignImage() {
    if (null == widget.testOrderInfo.signImage) {
      return new Container();
    }

    return new GestureDetector(
      onTap: () {
        showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  StringZh.signPic,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 1.1),
                ),
                content: _buildSign(),
              );
            });
      },
      child: new Container(
        width: 60.0,
        child: _buildSign(),
      ),
    );
  }

  Widget _buildSign() {
    if (null == widget.testOrderInfo.signImage.localFile) {
      return new FutureBuilder<Uint8List>(
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return new Container(
              child: new Text(StringZh.imageError),
            );
          }
          if (!snapshot.hasData) {
            return new Container(
              child: new Text(StringZh.picture_is_gone),
            );
          }
          return new Image.memory(
            snapshot.data,
            //fit: BoxFit.fill,
          );
        },
        future: widget.testOrderInfo.signImage.uint8list,
      );
    } else {
      return new Image.file(
        widget.testOrderInfo.signImage.localFile,
        //fit: BoxFit.fill,
      );
    }
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
