import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetailTestQuota.dart';
import 'package:qms/common/modal/TestOrderSampleDetail.dart';
import 'package:qms/common/net/QmsSampleService.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/TestOrderSampleService.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/TestOrderSampleBodyItemPage.dart';
import 'package:qms/page/TestOrderSampleHeadInfoPage.dart';
import 'package:qms/page/TestOrderSampleItemListPage.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/TextWidget.dart';

///检验单详情
///按样本检验
class TestOrderSamplePage extends StatefulWidget {
  ///单据ID
  final int id;

  ///单据号
  final String docNo;

  ///单据类型
  final String docCat;

  ///检验类型
  final String testCat;

  ///标题
  final String title;

  ///报检数量
  final String qty;

  ///来源单据详情ID
  final String srcDocDetailId;

  ///检验模板ID
  final String testTemplateId;

  ///检验模板名称
  final String testTemplateName;

  ///物料分类编码
  final String invCatCode;

  TestOrderSamplePage({
    Key key,
    this.id,
    this.docNo,
    @required this.docCat,
    @required this.testCat,
    @required this.title,
    this.qty,
    this.srcDocDetailId,
    this.testTemplateId,
    this.testTemplateName,
    this.invCatCode,
  }) : super(key: key);

  @override
  TestOrderSamplePageState createState() => new TestOrderSamplePageState();
}

class TestOrderSamplePageState extends State<TestOrderSamplePage> {
  ///检验单对象
  TestOrder testOrderInfo;

  ///检验单表体
  //List<TestOrderSampleDetail> testOrderDetailList = new List();

  ///缓存数据
  TestOrderSampleDetail cacheInfo;

  ///加载数据标识
  bool isLoading = true;

  ///整单判定背景色
  Color whole = RLZZColors.threeLevel;

  ///新增状态
  bool isAdd = false;

  ///审核状态
  bool auditStatus = false;

  ///指标附件
  List<Enclosure> quotaEnclosures = [];

  ///不良图像附件
  //List<Enclosure> badPictures = [];

  double width;

  ///选中指标索引
  int selIndex = 0;

  ///是否选中整单判定
  bool isAllSelect = false;

  ///加载指标列表
  bool isLoadingQuota = false;

  @override
  void initState() {
    super.initState();
    if (null == widget.id) {
      isAdd = true;
    }
    _getDataRequest();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///更新状态
  void changeState() {
    setState(() {});
  }

  ///初始化数据
  void _getDataRequest() {
    ///新增
    if (isAdd) {
      QmsSampleService.getTestOrderSample(
          context,
          widget.srcDocDetailId,
          widget.testTemplateId,
          widget.qty,
          widget.testCat,
          widget.docCat,
          _successCallBack,
          _errorCallBack);
    } else {
      ///检验单详情
      QmsSampleService.getTestOrderSampleById(
          context, widget.id, widget.docNo, _successCallBack, _errorCallBack);
    }
  }

  _successCallBack(res) {
    setState(() {
      testOrderInfo = TestOrder.fromJson(res);
      if (CommonUtil.isEmpty(testOrderInfo.testResult)) {
        testOrderInfo.testResult = Config.receive;
      }
      if (isAdd) {
        ///合格数量默认为报检数量
        testOrderInfo.qualifiedQty = testOrderInfo.quantity;
      }
      auditStatus = res['auditStatus'] ?? false;
      isLoading = false;

      ///默认第一个选中
      testOrderInfo.testOrderSampleDetail[0].color = RLZZColors.selectLevel;
      cacheInfo = testOrderInfo.testOrderSampleDetail[0];
    });
    getTestOrderDetailTestQuotaById();
  }

  _errorCallBack(err) {
    isLoading = false;
    Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
  }

  ///选中指标之后初始化数据
  _changeQuotaItemInfo(int index, {bool isAll: false}) {
    if (selIndex == index) {
      return;
    }

    ///整单判定
    if (isAll) {
      selIndex = -1;
      setState(() {
        whole = RLZZColors.selectLevel;
        isAllSelect = true;
        testOrderInfo.testOrderSampleDetail.forEach((k) {
          k.color = RLZZColors.threeLevel;
        });
      });
      //_getHeadBadPicturesListBytes();
      if (null == testOrderInfo.badEnclosureList) {
        testOrderInfo.badEnclosureList = [];
      }
    } else {
      setState(() {
        whole = RLZZColors.threeLevel;
        testOrderInfo.testOrderSampleDetail.forEach((k) {
          k.color = RLZZColors.threeLevel;
        });
        testOrderInfo.testOrderSampleDetail[index].color =
            RLZZColors.selectLevel;
        selIndex = index;
        cacheInfo = testOrderInfo.testOrderSampleDetail[index];
        if (cacheInfo.testOrderDetailTestQuota == null) {
          cacheInfo.testOrderDetailTestQuota = [];
        }
        isAllSelect = false;
      });
      if (cacheInfo.testOrderDetailTestQuota.length == 0) {
        getTestOrderDetailTestQuotaById();
      }

      /*setState(() {
        whole = RLZZColors.threeLevel;
        testOrderInfo.testOrderSampleDetail.forEach((k) {
          k.color = RLZZColors.threeLevel;
        });
        testOrderInfo.testOrderSampleDetail[index].color =
            RLZZColors.selectLevel;
        selIndex = index;
        cacheInfo = testOrderInfo.testOrderSampleDetail[index];
        isAllSelect = false;
      });*/
    }
  }

  ///获取指标列表
  getTestOrderDetailTestQuotaById() {
    if (testOrderInfo.id != null) {
      setState(() {
        isLoadingQuota = true;
      });
      //WidgetUtil.showLoadingDialog(context, '加载指标详情...');
      String oper = 'edit';

      String testTemplateId;
      if (null != widget.testTemplateId) {
        testTemplateId = widget.testTemplateId.toString();
      } else {
        testTemplateId = testOrderInfo.testTemplateId;
      }

      QmsSampleService.getTestOrderDetailTestQuotaById(
          context, oper, testOrderInfo.id, cacheInfo.id, testTemplateId, (res) {
        ///指标列表
        List<TestOrderDetailTestQuota> testOrderDetailTestQuotaList = [];

        for (int i = 0; i < res.length; i++) {
          TestOrderDetailTestQuota vo =
              TestOrderDetailTestQuota.fromJson(res[i]);
          testOrderDetailTestQuotaList.add(vo);
        }

        setState(() {
          cacheInfo.testOrderDetailTestQuota = testOrderDetailTestQuotaList;
          isLoadingQuota = false;
        });

        //Navigator.pop(context);
      }, (err) {
        Fluttertoast.showToast(
            msg: StringZh.quotaLoadingError, timeInSecForIos: 3);
        //Navigator.pop(context);
        setState(() {
          isLoadingQuota = false;
        });
      });
    }
  }

  ///获取表头不良图片
  /*_getHeadBadPicturesListBytes() {
    //selectDetailInfo.badPictures ="[{'name':'WX20190412-170313@2x.png','id':'1116627908940529664','size':'72819'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'}]";

    if (null == testOrderInfo.badEnclosureList) {
      testOrderInfo.badEnclosureList = [];

      ///获取数据为空时清除列表
      if (CommonUtil.isEmpty(testOrderInfo.enclosure)) {
        return;
      }
      List<Enclosure> badPictures = List();
      List arr = json.decode(testOrderInfo.enclosure.replaceAll('\'', '"'));
      arr.forEach((f) {
        badPictures.add(Enclosure.fromJson(f));
      });
      ApiUtil.downloadFileList(context, badPictures, () {
        ///更新列表状态
        setState(() {
          */ /*for (int i = 0; i < data.length; i++) {
            print(data[i]);
            badPictures[i].uint8list = data[i];
          }*/ /*
          testOrderInfo.badEnclosureList = badPictures;
        });
      }, (err) {
        _errorCallBack(StringZh.imageLoadingError);
      });
    }
  }
*/

  ///单据表头信息
  List<Widget> _getHeadInfo() {
    List<Widget> list = new List();
    if (CommonUtil.isNotEmpty(testOrderInfo.docNo)) {
      list.add(_getHeadWidget('单号：', testOrderInfo.docNo, 150.0));
    }
    list.add(_getHeadWidget(
        '物料：',
        testOrderInfo.invCode ?? '' + ' ' + testOrderInfo.invName ?? '',
        250.0));

    /*if (widget.docCat == Config.ARRIVAL) {
      list.add(_getHeadWidget(testOrderInfo.supplierName, 200.0));
    }

    if (widget.docCat == Config.COMPLETE) {
      list.add(_getHeadWidget(testOrderInfo.cusName, 150.0));
    }*/

    list.add(_getHeadWidget('来源单据号：', testOrderInfo.srcDocNo, 150.0));
    list.add(_getHeadWidget('检验数量：', testOrderInfo.quantity.toString(), 50.0));
    list.add(_getHeadWidget('样本数量：', testOrderInfo.sampleQty.toString(), 50.0));

    /*if (widget.docCat == Config.COMPLETE) {
      list.add(_getHeadWidget(testOrderInfo.batchNumber, 60.0));
    }

    if (widget.docCat == Config.COMPLETE) {
      list.add(_getHeadWidget(testOrderInfo.moDocNo, 100.0));
    }*/
    return list;
  }

  _getHeadWidget(String label, String text, double width,
      {Function onTapFun, Function onLongPress}) {
    return new TextWidget(
      text: text,
      margin: EdgeInsets.only(right: 4.0, left: 4.0),
      height: 30.0,
      width: width,
      onTapFun: () {
        if (onTapFun == null) {
          WidgetUtil.showRemark(context, remark: label + text ?? '');
        } else {
          onTapFun();
        }
      },
      onLongPress: onLongPress,
    );
  }

  ///获取表体信息，封装控件
  Widget _getDetailInfo() {
    if (isAllSelect) {
      return new TestOrderSampleHeadInfoPage(
        testOrderInfo: testOrderInfo,
        isAdd: isAdd,
        auditStatus: auditStatus,
      );
    } else {
      return new TestOrderSampleBodyItemPage(
          testOrderInfo: testOrderInfo,
          cacheInfo: cacheInfo,
          isAdd: isAdd,
          auditStatus: auditStatus,
          quotaEnclosures: quotaEnclosures,
          selIndex: selIndex,
          changeState: changeState,
          isLoadingQuota: isLoadingQuota);
    }
  }

  ///配置操作按钮
  List<Widget> _getOperBtns() {
    List<Widget> btnList = [];

    if (!isAdd && isAllSelect) {
      if (!auditStatus) {
        btnList.add(_getOperBtn(StringZh.audit, () {
          TestOrderSampleService.checkAuditPermissions(context, testOrderInfo);
        }, 80.0, 45.0, 40.0));
        btnList.add(_getOperBtn(StringZh.del, () {
          TestOrderSampleService.checkDelPermissions(context, testOrderInfo);
        }, 80.0, 45.0, 40.0));
      } else {
        btnList.add(_getOperBtn(StringZh.unAudit, () {
          TestOrderSampleService.checkUnauditPermissions(
              context, testOrderInfo);
        }, 80.0, 45.0, 80.0));
      }
    }

    if (isAllSelect) {
      if (!auditStatus) {
        btnList.add(_getOperBtn(StringZh.saveAllOrder, () {
          TestOrderSampleService.checkSavePermissions(context, widget.docCat,
              widget.testCat, setInfo, isAdd, testOrderInfo);
        }, 80.0, 45.0, 40.0));
      }
    } else {
      btnList.add(_getOperBtn(StringZh.saveAndSubmit, () {
        nextStepFun(isToLast: true);
      }, 160.0, 45.0, 40.0));
      btnList.add(_getOperBtn(StringZh.saveAndNextStep, () {
        nextStepFun();
      }, 160.0, 45.0, 40.0));
    }
    return btnList;
  }

  ///下一步操作
  void nextStepFun({bool isToLast: false}) {
    setInfo();
    List<TestOrderDetailTestQuota> list =
        testOrderInfo.testOrderSampleDetail[selIndex].testOrderDetailTestQuota;

    for (int i = 0; i < list.length; i++) {
      TestOrderDetailTestQuota tt = list[i];

      if (CommonUtil.isEmpty(tt.testVal)) {
        Fluttertoast.showToast(msg: '第${i + 1}行检测值不能为空', timeInSecForIos: 3);
        return;
      }
    }

    ///下一步操作，当前选中指标编辑状态修改，跳转到下一项指标
    testOrderInfo.testOrderSampleDetail[selIndex]
      ..edited = true
      ..quotaState = true;

    bool bo = false;
    if (isToLast) {
      bo = true;
    } else {
      if (selIndex + 1 == testOrderInfo.testOrderSampleDetail.length) {
        bo = true;
      }
    }
    _changeQuotaItemInfo(selIndex + 1, isAll: bo);
  }

  void setInfo() {
    if (selIndex == -1) {
      return;
    }
    /*testOrderDetailList[selIndex].badReasonId = cacheInfo.badReasonId;
    testOrderDetailList[selIndex].badReasonCode = cacheInfo.badReasonCode;
    testOrderDetailList[selIndex].badReasonName = cacheInfo.badReasonName;
    testOrderDetailList[selIndex].badEnclosureList = cacheInfo.badEnclosureList;
    //testOrderDetailList[selIndex].aqlData = cacheInfo.aqlData;
    testOrderDetailList[selIndex].testQtyInfo = cacheInfo.testQtyInfo;
    testOrderDetailList[selIndex].testQtyInfoDetailList =
        cacheInfo.testQtyInfoDetailList;
    testOrderDetailList[selIndex].qualifiedQty = cacheInfo.qualifiedQty;
    testOrderDetailList[selIndex].unQualifiedQty = cacheInfo.unQualifiedQty;
    testOrderDetailList[selIndex].badReasonInfo = cacheInfo.badReasonInfo;
    testOrderDetailList[selIndex].producer = cacheInfo.producer;*/
  }

  Widget _getOperBtn(String text, Function onTap, double width, double height,
      double marginRight) {
    return new GestureDetector(
      onTap: () {
        onTap();
      },
      child: new Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        margin: new EdgeInsets.only(right: marginRight),
        child: new Text(
          text,
          style: new TextStyle(
              fontSize: RLZZConstant.middleTextSize,
              color: RLZZColors.mainColor),
        ),
      ),
    );
  }

  Widget _renderItemListInfo() {
    Widget w = new TestOrderSampleItemListPage(
      testOrderInfo: testOrderInfo,
      changeQuotaItemInfo: _changeQuotaItemInfo,
      whole: whole,
    );
    return w;
  }

  @override
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);

    Widget mainW = isLoading
        ? WidgetUtil.getLoadingWidget(StringZh.loading)
        : new Column(
            children: <Widget>[
              new Container(
                width: width,
                height: 40.0,
                color: RLZZColors.threeLevel,
                child: new Row(
                  children: _getHeadInfo(),
                ),
              ),
              new Expanded(
                child: new Row(
                  children: <Widget>[
                    _renderItemListInfo(),
                    new Expanded(
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                margin: new EdgeInsets.all(10.0),
                                child: _getDetailInfo(),
                              ),
                            ),
                            new Container(
                              //width: width * 0.75,
                              height: 45.0,
                              color: RLZZColors.lightGray,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: _getOperBtns(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBarWidget(
          title: widget.title,
          /*backFun: () {
            //Navigator.pushAndRemoveUntil(
            //context, new ArrivalWaitTaskListPage());
          },*/
        ),
        body: mainW);
  }
}
