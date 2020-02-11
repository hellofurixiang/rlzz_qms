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
import 'package:qms/page/RefPage.dart';
import 'package:qms/page/FileListPage.dart';
import 'package:qms/page/UploadImagePage.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';

///检验单表体详情
class PqcTestOrderSampleBodyItemPage extends StatefulWidget {
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

  PqcTestOrderSampleBodyItemPage({
    Key key,
    @required this.testOrderInfo,
    @required this.cacheInfo,
    @required this.isAdd,
    @required this.auditStatus,
    @required this.quotaEnclosures,
    @required this.selIndex,
    @required this.changeState,
    @required this.isLoadingQuota,
    //this.testOrderDetailTestQuotaList,
  }) : super(key: key);

  @override
  PqcTestOrderSampleBodyItemPageState createState() =>
      new PqcTestOrderSampleBodyItemPageState();
}

class PqcTestOrderSampleBodyItemPageState
    extends State<PqcTestOrderSampleBodyItemPage> {
  double width;

  ///备注
  TextEditingController remarkController = new TextEditingController();

  ///样本条码
  TextEditingController barcodeController = new TextEditingController();

  ///测量工具
  TextEditingController measuringToolController = new TextEditingController();

  ///指标列表中的输入框控制器
  List<TextEditingController> testValCtlList = [];

  ///检验结果
  List<DropdownMenuItem> resultItems = [];

  @override
  void initState() {
    super.initState();

    resultItems =
        Config.testResult_pqc.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    ///初始化数据
    if (widget.cacheInfo.testOrderDetailTestQuota == null) {
      widget.cacheInfo.testOrderDetailTestQuota = [];
    }

    ///修改输入框
    _setDetailControllerInfo();
  }

  @override
  void didUpdateWidget(PqcTestOrderSampleBodyItemPage oldWidget) {
    //print('组件状态改变：didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    _setDetailControllerInfo();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    barcodeController.dispose();
    measuringToolController.dispose();
    remarkController.dispose();
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
    measuringToolController.text = widget.cacheInfo.measuringTool ?? '';

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
          margin: new EdgeInsets.only(bottom: 10.0),
          color: SetColors.itemBodyColor,
          child: new Row(
            children: <Widget>[
              /*new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10.0),
                child: new Text(
                  StringZh.nowSample + '：' + (widget.selIndex + 1).toString(),
                  style: new TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.black),
                ),
              ),*/
              getLabelWidget(StringZh.tick, 40.0),
              getEnabledWidget(
                  widget.cacheInfo.tick == null
                      ? ''
                      : widget.cacheInfo.tick.toString(),
                  50),
              getLabelWidget(StringZh.operator, 60.0),
              getEnabledWidget(widget.cacheInfo.operator ?? '', 80.0),
              getLabelWidget(StringZh.state, 60.0),
              getStateWidget(),
              getLabelWidget(StringZh.testTime, 70.0),
              getEnabledWidget(
                  CommonUtil.getDateFromTimeStamp(
                      widget.cacheInfo.testTime.toString(),
                      dateFormat: Config.formatDateTime),
                  130.0),
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
                            FieldConfig.testOrderDetailQuotaList),
                        children: <TableRow>[
                          new TableRow(
                            children: WidgetUtil.renderTableHeadColumnsByConfig(
                                FieldConfig.testOrderDetailQuotaList),
                          )
                        ]),
                    new Container(
                      padding: EdgeInsets.only(bottom: 1.0),
                      child: new Table(
                        columnWidths: WidgetUtil.getTableColumnWidth(
                            FieldConfig.testOrderDetailQuotaList),
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
          //height: 50.0,
          color: SetColors.itemBodyColor,
          padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    width: 70.0,
                    child: new Text.rich(
                      new TextSpan(
                        text: '* ',
                        children: [
                          new TextSpan(
                              text: StringZh.sampleBarcode,
                              style: new TextStyle(
                                  fontSize: SetConstants.normalTextSize,
                                  color: SetColors.black)),
                        ],
                      ),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: SetConstants.smallTextSize,
                          color: SetColors.red),
                      //maxLines: 2,
                    ),
                  ),
                  new Container(
                    height: 30.0,
                    width: 300.0,
                    child: new InputWidget(
                      enabled: widget.cacheInfo.id == null ? true : false,
                      controller: barcodeController,
                      onChanged: (v) {
                        changeSampleBarcode(v);
                      },
                    ),
                  ),
                  new Container(
                    child: new Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        getLabelWidget(StringZh.measuringTool, 70.0),
                        new Container(
                          height: 30.0,
                          width: 180.0,
                          child: new InputWidget(
                            controller: measuringToolController,
                            onChanged: (v) {
                              widget.cacheInfo.measuringTool = v;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Container(
                margin: EdgeInsets.only(top: 10.0),
                child: new Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 5.0, left: 5.0),
                      width: 70.0,
                      child: new Text(
                        StringZh.remark,
                        style: new TextStyle(
                            fontSize: SetConstants.normalTextSize,
                            color: SetColors.black),
                      ),
                    ),
                    new Container(
                      height: 30.0,
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
          ),
        ),
      ],
    );
  }

  changeSampleBarcode(String sampleBarcode) {
    int tick = 0;
    for (TestOrderSampleDetail vo
        in widget.testOrderInfo.testOrderSampleDetail) {
      if (vo.sampleBarcode != sampleBarcode) {
        continue;
      }
      if (vo.tick > tick) {
        tick = vo.tick;
      }
    }
    widget.cacheInfo.sampleBarcode = sampleBarcode;

    setState(() {
      widget.cacheInfo.tick = tick + 1;
      widget.cacheInfo.testTime = new DateTime.now().millisecondsSinceEpoch;
    });
  }

  Widget getStateWidget() {
    return CommonUtil.isEmpty(widget.cacheInfo.id)
        ? new Container(
            width: 80.0,
            //height: 40.0,
            color: SetColors.white,
            margin: new EdgeInsets.only(top: 4.0, bottom: 4.0),
            padding: new EdgeInsets.only(left: 5.0),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton(
                items: resultItems,
                onChanged: (value) {
                  setState(() {
                    widget.cacheInfo.state = value;
                  });
                },
                value: widget.cacheInfo.state,
                //hint: new Text(StringZh.prompt_sob),
                style: new TextStyle(
                    fontSize: SetConstants.normalTextSize, color: Colors.black),
                //iconEnabledColor: Colors.white,
              ),
            ),
          )
        : getEnabledWidget(widget.cacheInfo.state ?? '', 80.0);
  }

  Widget getLabelWidget(String labelText, double width,
      {EdgeInsetsGeometry margin}) {
    return new Container(
      alignment: Alignment.centerRight,
      margin: margin ?? EdgeInsets.only(right: 5.0, left: 5.0),
      width: width,
      child: new Text(
        labelText,
        style: new TextStyle(
            fontSize: SetConstants.normalTextSize, color: SetColors.black),
      ),
    );
  }

  Widget getEnabledWidget(String text, double width) {
    return new Container(
      height: 30.0,
      width: width,
      padding: EdgeInsets.only(left: 3.0),
      alignment: Alignment.centerLeft,
      color: SetColors.lightLightGrey,
      child: new Text(text),
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
              context, i, FieldConfig.testOrderDetailQuotaList)));
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

    cellList.add(getTextWidget(obj.state ? Config.abnormal : Config.normal,
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
        color: SetColors.lightLightGrey,
        border: new Border(
            right: new BorderSide(color: SetColors.darkGrey, width: 0.5),
            bottom: new BorderSide(color: SetColors.darkGrey, width: 0.5)),
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
              color: SetColors.darkDarkGrey,
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
    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      color: SetColors.lightLightGrey,
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
          StringZh.uploadImage,
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: SetConstants.smallTextSize,
              color: SetColors.mainColor,
              decoration: TextDecoration.underline),
        ),
        decoration: boxDecoration,
      ),
    );
  }

  ///查看文件
  Widget getFileWidget(String enclosure) {
    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      color: SetColors.lightLightGrey,
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
          StringZh.viewAttachment,
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: SetConstants.smallTextSize,
              color: bo ? SetColors.lightLightGrey : SetColors.mainColor,
              decoration: bo ? TextDecoration.none : TextDecoration.underline),
        ),
        decoration: boxDecoration,
      ),
    );
  }

  ///获取文本控件
  Widget getTextWidget(String fieldStr,
      {bool bo: false, Color fontColor: Colors.black}) {
    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = bo
        ? new BoxDecoration(
            color: SetColors.lightLightGrey,
            border: new Border(
                right: borderSide, bottom: borderSide, left: borderSide),
          )
        : new BoxDecoration(
            color: SetColors.lightLightGrey,
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
                fontSize: SetConstants.smallTextSize, color: fontColor),
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
    /*///一般缺陷数
    int generalDefectsQty = 0;

    ///主要缺陷数
    int majorDefectsQty = 0;

    ///严重缺陷数
    int seriousDefectsQty = 0;*/
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

      bool bo = true;
      for (int i = 0;
          i < widget.cacheInfo.testOrderDetailTestQuota.length;
          i++) {
        TestOrderDetailTestQuota tq =
            widget.cacheInfo.testOrderDetailTestQuota[i];
        if (tq.state) {
          bo = false;
          break;
        }
      }
      widget.cacheInfo.state = bo ? Config.qualified : Config.unqualified;
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
          return new RefPage(
            title: StringZh.text_badReason,
            url: Config.qmsApiUrl + Config.badReasonRefUrl,
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
  ///指标对象
  ///控制器
  ///修改回调方法
  ///是否为数字
  Widget getInputWidget(TestOrderDetailTestQuota vo,
      TextEditingController controller, Function changeInfo,
      {bool isNumber: false}) {
    controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: controller.text.length));

    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

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
            fontSize: SetConstants.normalTextSize, color: Colors.black),
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
