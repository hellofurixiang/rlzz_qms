import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';
import 'package:qms/common/net/ApiUtil.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ArrivalTestOrderListPage.dart';
import 'package:qms/page/ProductionOrderPage.dart';
import 'package:qms/page/TestOrderBodyItemPage.dart';
import 'package:qms/page/TestOrderHeadInfoPage.dart';
import 'package:qms/page/TestOrderItemQuotaPage.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/TextWidget.dart';

///检验单详情
class TestOrderPage extends StatefulWidget {
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

  TestOrderPage({
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
  TestOrderPageState createState() => new TestOrderPageState();
}

class TestOrderPageState extends State<TestOrderPage> {
  ///检验单对象
  TestOrder testOrderInfo;

  ///检验单表体
  List<TestOrderDetail> testOrderDetailList = new List();

  ///缓存数据
  TestOrderDetail cacheInfo;

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

  ///初始化数据
  void _getDataRequest() {
    ///新增
    if (isAdd) {
      QmsService.getTestTaskDetail(
          context,
          {
            'id': widget.srcDocDetailId,
            'testTemplateId': widget.testTemplateId,
            'testTemplateName': widget.testTemplateName,
            'checkQty': widget.qty,
            'invCatCode': widget.invCatCode,
            'docCat': widget.docCat,
          },
          _successCallBack,
          _errorCallBack);
    } else {
      ///检验单详情
      QmsService.getTestOrderById(
          context, widget.id, widget.docNo, _successCallBack, _errorCallBack);
    }
  }

  _successCallBack(res) {
    setState(() {
      testOrderInfo = TestOrder.fromJson(res);
      if (CommonUtil.isEmpty(testOrderInfo.testResult)) {
        testOrderInfo.testResult = '接收';
      }

      if (isAdd) {
        ///合格数量默认为报检数量
        testOrderInfo.qualifiedQty = testOrderInfo.quantity;
      }
      auditStatus = res['auditStatus'] ?? false;
      isLoading = false;
    });

    ///检验项目列表
    List<TestOrderDetail> testItemList = new List();

    ///通过检验项目分组，相同项目的指标放一组
    for (int j = 0; j < testOrderInfo.testOrderDetail.length; j++) {
      var f = testOrderInfo.testOrderDetail[j];
      f.badEnclosureList = List();

      //f['color'] = j == 0 ? RLZZColors.selectLevel : RLZZColors.threeLevel;

      bool bo = true;
      for (int i = 0; i < testItemList.length; i++) {
        if (f.testItemCode == testItemList[i].testItemCode) {
          bo = false;
          break;
        }
      }
      if (bo) {
        testItemList.add(f);
      }
    }

    bool bo = true;
    testItemList.forEach((f) {
      ///检验项目
      var testItemCode = f.testItemCode;
      for (int i = 0; i < testOrderInfo.testOrderDetail.length; i++) {
        TestOrderDetail v = testOrderInfo.testOrderDetail[i];
        v.edited = v.edited ?? false;

        if (testItemCode == v.testItemCode) {
          if (bo) {
            ///默认第一个选中
            v.color = RLZZColors.selectLevel;
            cacheInfo = v;
            bo = false;
          }

          ///排序后数据
          testOrderDetailList.add(v);
        }
      }
    });
  }

  _errorCallBack(err) {
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
        testOrderDetailList.forEach((k) {
          k.color = RLZZColors.threeLevel;
        });
      });
      if (testOrderInfo.docCat == Config.test_order_complete) {
        _getHeadSignBytes();
      }
      //_getHeadBadPicturesListBytes();
      if (null == testOrderInfo.badEnclosureList) {
        testOrderInfo.badEnclosureList = [];
      }
    } else {
      setState(() {
        whole = RLZZColors.threeLevel;
        testOrderDetailList.forEach((k) {
          k.color = RLZZColors.threeLevel;
        });
        testOrderDetailList[index].color = RLZZColors.selectLevel;
        selIndex = index;
        cacheInfo = testOrderDetailList[index];
        isAllSelect = false;
      });
      //_setDetailControllerInfo();
      //_getQuotaImageListBytes();

      ///获取不良图片
      //_getBadPicturesListBytes();
      if (null == cacheInfo.badEnclosureList) {
        cacheInfo.badEnclosureList = [];
      }
    }
  }

  /*///获取指标图片附件
  _getQuotaImageListBytes() {
    //selectDetailInfo.enclosure ="[{'name':'WX20190412-170313@2x.png','id':'1116627908940529664','size':'72819'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'}]";

    ///获取数据为空时清除列表
    if (CommonUtil.isEmpty(cacheInfo.enclosure)) {
      //setState(() {
      quotaEnclosures.clear();
      //});
      return;
    }

    ///先清除再追加
    quotaEnclosures.clear();
    List arr = json.decode(cacheInfo.enclosure.replaceAll('\'', '"'));
    arr.forEach((f) {
      quotaEnclosures.add(Enclosure.fromJson(f));
    });
    */ /*ApiUtil.getImageListBytes(quotaEnclosures, (data) {
      ///更新列表状态
      setState(() {
        for (int i = 0; i < data.length; i++) {
          quotaEnclosures[i].uint8list = data[i];
        }
      });
    });*/ /*
  }

  ///获取不良图片
  _getBadPicturesListBytes() {
    //selectDetailInfo.badPictures ="[{'name':'WX20190412-170313@2x.png','id':'1116627908940529664','size':'72819'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'}]";

    if (null == cacheInfo.badEnclosureList ||
        cacheInfo.badEnclosureList.length == 0) {
      ///获取数据为空时清除列表
      if (CommonUtil.isEmpty(cacheInfo.badPictures)) {
        return;
      }
      List<Enclosure> badPictures = List();
      List arr = json.decode(cacheInfo.badPictures.replaceAll('\'', '"'));
      arr.forEach((f) {
        badPictures.add(Enclosure.fromJson(f));
      });
      ApiUtil.downloadFileList(context, badPictures, () {
        ///更新列表状态
        setState(() {
          */ /*for (int i = 0; i < data.length; i++) {
            badPictures[i].thumbnail = data[i];
          }*/ /*
          cacheInfo.badEnclosureList = badPictures;
        });
      }, (err) {
        _errorCallBack('图片加载异常...');
      });
    }
  }

  ///获取表头不良图片
  _getHeadBadPicturesListBytes() {
    //selectDetailInfo.badPictures ="[{'name':'WX20190412-170313@2x.png','id':'1116627908940529664','size':'72819'},{'name':'WX20190221-094239@2x.png','id':'1116627911645855744','size':'331274'}]";

    if (null == testOrderInfo.badEnclosureList) {
      testOrderInfo.badEnclosureList = [];
    } else {
      return;
    }

    ///获取数据为空时清除列表
    if (CommonUtil.isEmpty(testOrderInfo.enclosure)) {
      return;
    }
    List<Enclosure> badPictures = List();
    List arr = json.decode(testOrderInfo.enclosure.replaceAll('\'', '"'));
    arr.forEach((f) {
      badPictures.add(Enclosure.fromJson(f));
    });
    ApiUtil.downloadFileList(context, badPictures, (data) {
      ///更新列表状态
      setState(() {
        */ /*for (int i = 0; i < data.length; i++) {
          badPictures[i].thumbnail = data[i];
        }*/ /*
        testOrderInfo.badEnclosureList = badPictures;
      });
    }, (err) {
      _errorCallBack('图片加载异常');
    });
  }
*/

  ///获取签名图片
  _getHeadSignBytes() {
    if (null != testOrderInfo.signImage) {
      return;
    }

    ///获取数据为空时清除列表
    if (CommonUtil.isEmpty(testOrderInfo.signPic)) {
      return;
    }
    var arr = json.decode(testOrderInfo.signPic.replaceAll('\'', '"'));

    testOrderInfo.signImage = Enclosure.fromJson(arr);
    List<Enclosure> badPictures = List();
    badPictures.add(Enclosure.fromJson(arr));

    ApiUtil.downloadFileList(context, badPictures, (data) {
      ///更新列表状态
      setState(() {
        //badPictures[0].uint8list = data[0];
        testOrderInfo.signImage = badPictures[0];
      });
    }, (err) {
      _errorCallBack('图片加载异常');
    });
  }

  ///单据表头信息
  List<Widget> _getHeadInfo() {
    List<Widget> list = new List();
    if (CommonUtil.isNotEmpty(testOrderInfo.docNo)) {
      list.add(_getHeadWidget(testOrderInfo.docNo, 150.0));
    }
    list.add(_getHeadWidget(
        testOrderInfo.invCode + '' + testOrderInfo.invName, 250.0));

    if (widget.docCat == Config.test_order_arrival) {
      list.add(_getHeadWidget(testOrderInfo.supplierName, 200.0));
    }

    if (widget.docCat == Config.test_order_complete) {
      list.add(_getHeadWidget(testOrderInfo.cusName, 150.0));
    }

    list.add(_getHeadWidget(testOrderInfo.srcDocNo, 100.0));
    list.add(_getHeadWidget(testOrderInfo.quantity.toString(), 50.0));

    if (widget.docCat == Config.test_order_complete) {
      list.add(_getHeadWidget(testOrderInfo.batchNumber, 60.0));
    }

    if (widget.docCat == Config.test_order_complete) {
      list.add(_getHeadWidget(testOrderInfo.moDocNo, 100.0,onTapFun: (){
        ///生产订单
        showDialog<Null>(
            context: context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new ProductionOrderPage(
                detailId: testOrderInfo.moDetailId,
                moDocNo: testOrderInfo.moDocNo
              );
            });

      }));
    }
    return list;
  }

  _getHeadWidget(String text, double width,{Function onTapFun}) {
    return new TextWidget(
      text: text,
      margin: EdgeInsets.only(right: 4.0, left: 4.0),
      height: 30.0,
      width: width,
      onTapFun: () {
        if(onTapFun==null) {
          if (null != text) {
            WidgetUtil.showRemark(context, remark: text);
          }
        }else{
          onTapFun();
        }
      },
    );
  }

  ///获取表体信息，封装控件
  Widget _getDetailInfo() {
    if (isAllSelect) {
      return new TestOrderHeadInfoPage(
        testOrderInfo: testOrderInfo,
        isAdd: isAdd,
        auditStatus: auditStatus,
      );
    } else {
      return new TestOrderBodyItemPage(
          testOrderInfo: testOrderInfo,
          testOrderDetailList: testOrderDetailList,
          cacheInfo: cacheInfo,
          isAdd: isAdd,
          auditStatus: auditStatus);
    }
  }

  ///配置操作按钮
  List<Widget> _getOperBtns() {
    List<Widget> btnList = [];

    if (!isAdd && isAllSelect) {
      if (!auditStatus) {
        btnList.add(_getOperBtn(StringZh.audit, () {
          WidgetUtil.showLoadingDialog(context, StringZh.auditing);
          QmsService.auditTestOrder(
              context,
              testOrderInfo.id,
              testOrderInfo.docCat,
              testOrderInfo.version,
              operSuccessCallBack,
              () {});
        }, 80.0, 45.0, 40.0));
        btnList.add(_getOperBtn(StringZh.del, () {
          QmsService.delTestOrder(
              context,
              testOrderInfo.id,
              testOrderInfo.docCat,
              testOrderInfo.version,
              operSuccessCallBack,
              () {});
        }, 80.0, 45.0, 40.0));
      } else {
        btnList.add(_getOperBtn(StringZh.unAudit, () {
          QmsService.unAuditTestOrder(
              context,
              testOrderInfo.id,
              testOrderInfo.docCat,
              testOrderInfo.version,
              operSuccessCallBack,
              () {});
        }, 80.0, 45.0, 80.0));
      }
    }

    if (!isAllSelect) {
      btnList.add(_getOperBtn(StringZh.skip, () {
        _changeQuotaItemInfo(selIndex + 1);
      }, 80.0, 45.0, 40.0));
    }
    //if (isAllSelect) {
    btnList.add(_getOperBtn(StringZh.submit, submitFun, 80.0, 45.0, 40.0));
    //}
    if (!isAllSelect) {
      btnList
          .add(_getOperBtn(StringZh.nextStep, nextStepFun, 80.0, 45.0, 40.0));
    }
    return btnList;
  }

  ///下一步操作
  void nextStepFun() {
    setInfo();

    ///下一步操作，当前选中指标编辑状态修改，跳转到下一项指标
    //setState(() {
    testOrderDetailList[selIndex].edited = true;
    //});

    bool bo = false;
    if (selIndex + 1 == testOrderDetailList.length) {
      bo = true;
    }
    _changeQuotaItemInfo(selIndex + 1, isAll: bo);
  }

  void setInfo() {
    if (selIndex == -1) {
      return;
    }
    testOrderDetailList[selIndex]
      ..edited = true
      ..badReasonCode = cacheInfo.badReasonCode
      ..badReasonName = cacheInfo.badReasonName
      ..badEnclosureList = cacheInfo.badEnclosureList
      //..aqlData = cacheInfo.aqlData;
      ..testQtyInfo = cacheInfo.testQtyInfo
      ..testQtyInfoDetailList = cacheInfo.testQtyInfoDetailList
      ..qualifiedQty = cacheInfo.qualifiedQty
      ..unQualifiedQty = cacheInfo.unQualifiedQty
      ..badReasonInfo = cacheInfo.badReasonInfo
      ..producer = cacheInfo.producer;
  }

  ///提交操作
  void submitFun() async {
    setInfo();

    if (isAdd) {
      testOrderInfo.docCat = widget.docCat;
      testOrderInfo.testCat = widget.testCat;
    }

    ///表头附件
    if (null != testOrderInfo.badEnclosureList &&
        testOrderInfo.badEnclosureList.length > 0) {
      List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
      testOrderInfo.badEnclosureList.forEach((v) {
        if (CommonUtil.isNotEmpty(v.id)) {
          AttachmentVo attachmentVo = AttachmentVo.empty()
            ..id = v.id
            ..name = v.name
            ..size = v.size;
          badEnclosureList.add(attachmentVo);
        }
      });
      testOrderInfo.enclosureList = badEnclosureList;
    } else {
      if (CommonUtil.isNotEmpty(testOrderInfo.enclosure)) {
        List arr = json.decode(testOrderInfo.enclosure.replaceAll('\'', '"'));

        List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
        arr.forEach((v) {
          badEnclosureList.add(AttachmentVo.fromJson(v));
        });
        testOrderInfo.enclosureList = badEnclosureList;
      }
    }

    ///表体附件
    testOrderInfo.testOrderDetail.forEach((f) {
      List list = f.testQtyInfoDetailList;

      f.operTestQtyInfo = f.edited;

      if (list != null && list.isNotEmpty && f.edited) {
        f.testQtyInfoDetail =json.encode(list);//.replaceAll('detailList', 'list');
      } else {
        f.testQtyInfoDetail = 'noChange';
      }

      if (null != f.badEnclosureList && f.badEnclosureList.length > 0) {
        List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
        f.badEnclosureList.forEach((v) {
          if (CommonUtil.isNotEmpty(v.id)) {
            AttachmentVo attachmentVo = AttachmentVo.empty()
              ..id = v.id
              ..name = v.name
              ..size = v.size;
            badEnclosureList.add(attachmentVo);
          }
        });
        f.enclosureList = badEnclosureList;
      } else {
        if (CommonUtil.isNotEmpty(f.enclosure)) {
          List arr = json.decode(f.enclosure.replaceAll('\'', '"'));

          List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
          arr.forEach((v) {
            badEnclosureList.add(AttachmentVo.fromJson(v));
          });
          f.enclosureList = badEnclosureList;
        }
      }
    });

    WidgetUtil.showLoadingDialog(context, StringZh.submiting);
    QmsService.submitTestOrder(context, testOrderInfo, (data) {
      Fluttertoast.showToast(msg: data, timeInSecForIos: 3);

      ///消除加载控件
      Navigator.pop(context);

      ///回退
      Navigator.pop(context);



      ///跳转
      String urlName='';

      switch(widget.docCat){
        case Config.test_order_complete:
          if (null != testOrderInfo.id) {
            urlName = Config.completeTestOrderListPage;
          } else {
            urlName = Config.completeWaitTaskListPage;
          }
          break;
        case Config.test_order_arrival:
          if (null != testOrderInfo.id) {
            urlName = Config.arrivalTestOrderListPage;
          } else {
            urlName = Config.arrivalWaitTaskListPage;
          }
          break;
        case Config.test_order_iqc:
          if (null != testOrderInfo.id) {
            urlName = Config.iqcTestOrderListPage;
          } else {
            urlName = Config.iqcWaitTaskListPage;
          }
          break;
        case Config.test_order_fqc:
          if (null != testOrderInfo.id) {
            urlName = Config.fqcTestOrderListPage;
          } else {
            urlName = Config.fqcWaitTaskListPage;
          }
          break;
        default:
          break;
      }

      NavigatorUtil.pushReplacementNamed(context, urlName);
    }, (err) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
    });
  }

  ///审核、弃审、删除回调函数
  void operSuccessCallBack() {
    Navigator.pop(context);
    NavigatorUtil.goToPage(context, new ArrivalTestOrderListPage());
    Fluttertoast.showToast(msg: '操作成功', timeInSecForIos: 3);
  }

  void operErrorCallBack(err) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
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
    Widget w = new TestOrderItemQuotaPage(
      testOrderInfo: testOrderInfo,
      changeQuotaItemInfo: _changeQuotaItemInfo,
      whole: whole,
    );
    //_getQuotaImageListBytes();

    ///获取不良图片
    //_getBadPicturesListBytes();

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
        ),
        body: mainW);
  }
}
