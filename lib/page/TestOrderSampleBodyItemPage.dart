import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetailTestQuota.dart';
import 'package:qms/common/modal/TestOrderSampleDetail.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/BadReasonRefPage.dart';
import 'package:qms/page/FileListPage.dart';
import 'package:qms/page/UploadImagePage.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';

///检验单表体详情
class TestOrderSampleBodyItemPage extends StatefulWidget {
  ///检验单对象
  final TestOrder testOrderInfo;

  ///缓存数据
  final TestOrderSampleDetail cacheInfo;

  ///新增状态
  final bool isAdd;

  ///审核状态
  final bool auditStatus;

  ///指标附件
  final List<Enclosure> quotaEnclosures;

  ///选中数据索引
  final int selIndex;

  ///更新父页面状态
  final Function changeState;

  ///加载指标列表
  final bool isLoadingQuota;

  ///指标列表
  //final List<TestOrderDetailTestQuota> testOrderDetailTestQuotaList;

  TestOrderSampleBodyItemPage({
    Key key,
    this.testOrderInfo,
    this.cacheInfo,
    this.isAdd,
    this.auditStatus,
    this.quotaEnclosures,
    this.selIndex,
    this.changeState,
    this.isLoadingQuota,
    //this.testOrderDetailTestQuotaList,
  }) : super(key: key);

  @override
  TestOrderSampleBodyItemPageState createState() =>
      new TestOrderSampleBodyItemPageState();
}

class TestOrderSampleBodyItemPageState
    extends State<TestOrderSampleBodyItemPage> {
  double width;

  ///一般缺陷
  TextEditingController generalDefectsQtyController =
      new TextEditingController();

  ///主要缺陷
  TextEditingController majorDefectsQtyController = new TextEditingController();

  ///严重数量
  TextEditingController seriousDefectsQtyController =
      new TextEditingController();

  ///备注
  TextEditingController remarkController = new TextEditingController();

  ///样本条码
  TextEditingController barcodeController = new TextEditingController();

  ///指标列表中的输入框控制器
  List<TextEditingController> testValCtlList = [];

  @override
  void initState() {
    super.initState();

    if (widget.cacheInfo.testOrderDetailTestQuota == null) {
      widget.cacheInfo.testOrderDetailTestQuota = [];
    }

    ///修改输入框
    _setDetailControllerInfo();
  }

  @override
  void didUpdateWidget(TestOrderSampleBodyItemPage oldWidget) {
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
    /*unQualifiedQtyController.text = widget.cacheInfo.unQualifiedQty == null
        ? ''
        : widget.cacheInfo.unQualifiedQty.toString();
    qualifiedQtyController.text = widget.cacheInfo.qualifiedQty == null
        ? ''
        : widget.cacheInfo.qualifiedQty.toString();*/

    barcodeController.text = widget.cacheInfo.sampleBarcode ?? '';
    remarkController.text = widget.cacheInfo.remark ?? '';

    ///一般缺陷数
    getQtyInfo(generalDefectsQtyController, widget.cacheInfo.generalDefectsQty);

    ///主要缺陷数
    getQtyInfo(majorDefectsQtyController, widget.cacheInfo.majorDefectsQty);

    ///严重缺陷数
    getQtyInfo(seriousDefectsQtyController, widget.cacheInfo.seriousDefectsQty);

    testValCtlList.clear();
    widget.cacheInfo.testOrderDetailTestQuota.forEach((f) {
      TextEditingController testValCtl = new TextEditingController();
      testValCtl.text = f.testVal ?? '';
      testValCtlList.add(testValCtl);
    });
  }

  void getQtyInfo(TextEditingController ctl, var val) {
    ctl.text = val == null ? '' : val.toString();
  }

  ///获取表体信息，封装控件
  Widget _getDetailInfo() {
    return new Column(
      children: <Widget>[
        new Container(
          height: 40.0,
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          margin: new EdgeInsets.only(bottom: 10.0),
          color: RLZZColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 100.0, left: 5.0),
                child: new Text(
                  '当前样本：' + (widget.selIndex + 1).toString(),
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  '样本条码',
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: Colors.black),
                ),
              ),
              new Container(
                height: 30.0,
                width: 180.0,
                child: new InputWidget(
                  controller: barcodeController,
                  onChanged: (v) {
                    widget.cacheInfo.sampleBarcode = v;
                  },
                ),
              ),
            ],
          ),
        ),
        new Expanded(
          child: new ListView(
            children: <Widget>[
              new SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: new Column(
                  children: <Widget>[
                    new Table(
                        columnWidths: WidgetUtil.getTableColumnWidth(
                            QMSFieldConfig.testOrderDetailQuotaList),
                        children: <TableRow>[
                          new TableRow(
                            children: WidgetUtil.renderTableHeadColumnsByConfig(
                                QMSFieldConfig.testOrderDetailQuotaList),
                          )
                        ]),
                    new Container(
                      padding: EdgeInsets.only(bottom: 1.0),
                      child: new Table(
                        columnWidths: WidgetUtil.getTableColumnWidth(
                            QMSFieldConfig.testOrderDetailQuotaList),
                        children: getRows(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        new Container(
          //height: 30.0,
          color: RLZZColors.itemBodyColor,
          padding: new EdgeInsets.only(top: 10.0),
          child: new Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  '严重缺陷',
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
                  isNumber: true,
                  controller: seriousDefectsQtyController,
                  onChanged: (v) {
                    widget.cacheInfo.seriousDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  '主要缺陷',
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
                  isNumber: true,
                  controller: majorDefectsQtyController,
                  onChanged: (v) {
                    widget.cacheInfo.majorDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
                ),
              ),
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 60.0,
                child: new Text(
                  '一般缺陷',
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
                  isNumber: true,
                  controller: generalDefectsQtyController,
                  onChanged: (v) {
                    widget.cacheInfo.generalDefectsQty =
                        CommonUtil.getIntValue(v);
                  },
                ),
              ),
            ],
          ),
        ),
        new Container(
          height: 50.0,
          color: RLZZColors.itemBodyColor,
          padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                width: 70.0,
                child: new Text(
                  '描述',
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.darkDarkGrey),
                ),
              ),
              new Container(
                //height: 30.0,
                width: 300.0,
                child: new InputWidget(
                  controller: remarkController,
                  onChanged: (v) {
                    widget.cacheInfo.remark = v;
                  },
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

    return widget.isLoadingQuota
        ? WidgetUtil.getLoadingWidget(StringZh.quotaLoading)
        : _getDetailInfo();
  }

  List<TableRow> getRows() {
    List<TableRow> list = [];

    for (int i = 0; i < widget.cacheInfo.testOrderDetailTestQuota.length; i++) {
      list.add(new TableRow(
          children: renderItemByConfig(
              context, i, QMSFieldConfig.testOrderDetailQuotaList)));
    }
    return list;
  }

  List<Widget> renderItemByConfig(
      BuildContext context, int index, Map<String, Object> layoutConfig) {
    List<Widget> cellList = new List();

    TestOrderDetailTestQuota obj =
        widget.cacheInfo.testOrderDetailTestQuota[index];

    cellList.add(getTextWidget((index + 1).toString(), bo: true));
    cellList.add(getTextWidget(obj.testItemName));
    cellList.add(getTextWidget(obj.testQuotaName));
    cellList.add(getTextWidget(obj.quotaCat));
    cellList.add(getTextWidget(obj.standardValue));
    cellList.add(getTextWidget(obj.upperLimitValue));
    cellList.add(getTextWidget(obj.lowerLimitValue));

    TextEditingController testValController = TextEditingController.fromValue(
        TextEditingValue(text: obj.testVal ?? ''));
    //testValController.text = obj.testVal;

    cellList.add(getInputWidget(obj, testValController, changeTestVal));

    cellList.add(getTextWidget(obj.state ? '异常' : '正常',
        fontColor: obj.state ? Colors.red : Colors.black));

    cellList.add(getTextWidget(obj.testDecription));
    cellList.add(getFileWidget(obj.enclosure));
    cellList.add(getTextWidget(obj.testWay));
    cellList.add(getTextWidget(obj.samplingWay));
    cellList.add(getTextWidget(obj.defectLevel));

    cellList.add(getTextWidget(obj.inspectionEquipment));
    //cellList.add(getTextWidget(obj.badReasonName));

    cellList.add(new Container(
      decoration: new BoxDecoration(
        color: RLZZColors.lightLightGrey,
        border: new Border(
            right: new BorderSide(color: RLZZColors.darkGrey, width: 0.5),
            bottom: new BorderSide(color: RLZZColors.darkGrey, width: 0.5)),
      ),
      //margin: EdgeInsets.only(top: 2.0),
      alignment: Alignment.center,
      child: new TextWidget(
        height: 29.5,
        width: 100.0,
        text: obj.badReasonName,
        onTapFun: () {
          getReasonInfoModel(obj);
        },
        iconWidget: new GestureDetector(
          onTap: () {
            getReasonInfoModel(obj);
          },
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
    ));

    TextEditingController controller = new TextEditingController();
    controller.text = obj.badReasonInfo;

    cellList.add(getInputWidget(obj, controller, changeBadReasonInfo));

    TextEditingController producerController = new TextEditingController();
    producerController.text = obj.producer;

    cellList.add(getInputWidget(obj, producerController, changeProducer));

    cellList.add(getUploadImageWidget(obj));

    return cellList;
  }

  ///行高
  double cellHeight = 30.0;

  ///查看、上传图片
  Widget getUploadImageWidget(TestOrderDetailTestQuota obj) {
    var borderSide = new BorderSide(color: RLZZColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      color: RLZZColors.lightLightGrey,
      border: new Border(right: borderSide, bottom: borderSide),
    );
    if (null == obj.badEnclosureList) {
      obj.badEnclosureList = [];
    }
    return new GestureDetector(
      onTap: () {
        showDialog<Null>(
            context: context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new UploadImagePage(
                  obj.badPictures, obj.badEnclosureList, true);
            });
      },
      child: new Container(
        height: cellHeight,
        alignment: Alignment.center,
        padding: new EdgeInsets.all(2.0),
        child: new Text(
          '上传图片',
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: RLZZConstant.smallTextSize,
              color: RLZZColors.mainColor,
              decoration: TextDecoration.underline),
        ),
        decoration: boxDecoration,
      ),
    );
  }

  ///查看文件
  Widget getFileWidget(String enclosure) {
    var borderSide = new BorderSide(color: RLZZColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      color: RLZZColors.lightLightGrey,
      border: new Border(right: borderSide, bottom: borderSide),
    );
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
        height: cellHeight,
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
        decoration: boxDecoration,
      ),
    );
  }

  ///获取文本控件
  Widget getTextWidget(String fieldStr,
      {bool bo: false, Color fontColor: Colors.black}) {
    var borderSide = new BorderSide(color: RLZZColors.darkGrey, width: 0.5);

    var boxDecoration = bo
        ? new BoxDecoration(
            color: RLZZColors.lightLightGrey,
            border: new Border(
                right: borderSide, bottom: borderSide, left: borderSide),
          )
        : new BoxDecoration(
            color: RLZZColors.lightLightGrey,
            border: new Border(right: borderSide, bottom: borderSide),
          );
    return new GestureDetector(
      onTap: () {
        WidgetUtil.showRemark(context, remark: fieldStr);
      },
      child: new Container(
        height: cellHeight,
        alignment: Alignment.center,
        padding: new EdgeInsets.all(2.0),
        child: new SingleChildScrollView(
          child: new Text(
            fieldStr ?? '',
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: RLZZConstant.smallTextSize, color: fontColor),
          ),
        ),
        decoration: boxDecoration,
      ),
    );
  }

  void changeBadReasonInfo(
      TestOrderDetailTestQuota vo, String v, TextEditingController controller) {
    setState(() {
      vo.badReasonInfo = v;
    });
  }

  void changeProducer(
      TestOrderDetailTestQuota vo, String v, TextEditingController controller) {
    setState(() {
      vo.producer = v;
    });
  }

  void changeTestVal(
      TestOrderDetailTestQuota vo, String v, TextEditingController controller) {
    ///一般缺陷数
    int generalDefectsQty = 0;

    ///主要缺陷数
    int majorDefectsQty = 0;

    ///严重缺陷数
    int seriousDefectsQty = 0;
    setState(() {
      if (vo.quotaCat != Config.quotaTypeEntryNumber) {
        vo.state = false;
        vo.testVal = v;
      } else {
        double upperLimitValue = CommonUtil.stringToDouble(vo.upperLimitValue);
        double lowerLimitValue = CommonUtil.stringToDouble(vo.lowerLimitValue);
        double testVal = CommonUtil.stringToDouble(v);

        if (null == testVal) {
          controller.text = '';
          vo.testVal = '';
          vo.state = false;
        } else {
          if (null == lowerLimitValue || null == upperLimitValue) {
            vo.state = true;
          } else {
            if (testVal > lowerLimitValue && testVal < upperLimitValue) {
              vo.state = false;
            } else {
              vo.state = true;
            }
          }
          vo.testVal = v;
        }
      }

      widget.cacheInfo.testOrderDetailTestQuota.forEach((f) {
        if (f.state) {
          if (f.defectLevel == Config.generalDefectsQty) {
            generalDefectsQty++;
          }
          if (f.defectLevel == Config.majorDefectsQty) {
            majorDefectsQty++;
          }
          if (f.defectLevel == Config.seriousDefectsQty) {
            seriousDefectsQty++;
          }
        }
      });
      widget.cacheInfo
        ..generalDefectsQty = generalDefectsQty
        ..majorDefectsQty = majorDefectsQty
        ..seriousDefectsQty = seriousDefectsQty;

      ///一般缺陷数
      int generalDefectsQtyTotal = 0;

      ///主要缺陷数
      int majorDefectsQtyTotal = 0;

      ///严重缺陷数
      int seriousDefectsQtyTotal = 0;

      widget.testOrderInfo.testOrderSampleDetail.forEach((f) {
        generalDefectsQtyTotal += f.generalDefectsQty;
        majorDefectsQtyTotal += f.majorDefectsQty;
        seriousDefectsQtyTotal += f.seriousDefectsQty;
      });

      widget.testOrderInfo
        ..generalDefectsQty = generalDefectsQtyTotal
        ..majorDefectsQty = majorDefectsQtyTotal
        ..seriousDefectsQty = seriousDefectsQtyTotal;
    });

    widget.changeState();
    //});
  }

  ///获取不良原因
  void getReasonInfoModel(TestOrderDetailTestQuota ttq) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new BadReasonRefPage(
            arcCode: ttq.badReasonCode.toString(),
            okFun: (obj) {
              setState(() {
                ttq
                  ..badReasonCode = obj['arcCode']
                  ..badReasonName = obj['arcName'];
              });
            },
          );
        });
  }

  ///输入框
  Widget getInputWidget(TestOrderDetailTestQuota vo,
      TextEditingController controller, Function changeInfo,
      {bool isNumber: false}) {
    controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: controller.text.length));

    var borderSide = new BorderSide(color: RLZZColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      border: new Border(right: borderSide, bottom: borderSide),
    );

    List<TextInputFormatter> inputFormatters = [];
    TextInputType keyboardType = TextInputType.text;
    if (isNumber) {
      inputFormatters = [
        WhitelistingTextInputFormatter(CommonUtil.getRegExp('number'))
      ];

      keyboardType = TextInputType.number;
    }

    return new Container(
      alignment: Alignment.center,
      //margin: new EdgeInsets.all(2.0),
      height: cellHeight,
      //width: 150.0,
      decoration: boxDecoration,
      child: new TextField(
        //initText: initText,
        //maxLength: 200,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: (v) {
          changeInfo(vo, v, controller);
        },
        style: new TextStyle(
            fontSize: RLZZConstant.normalTextSize, color: Colors.black),
        //textAlign: TextAlign.center,
        decoration: new InputDecoration(
          ///输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
          contentPadding: EdgeInsets.all(4.0),
          filled: true,
          fillColor: Colors.white,
          // 以下属性可用来去除TextField的边框
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: new BorderSide(color: Colors.transparent, width: 1.0),
          ),
          /*suffixIcon: controller.text == ''
              ? null
              : new GestureDetector(
                  onTap: () {
                    controller.clear();
                    changeInfo(vo, '');
                  },
                  child: new Icon(
                    Icons.clear,
                    size: 20.0,
                  ),
                ),*/
        ),
      ),
    );
  }
}
