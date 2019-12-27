import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ListCommonState.dart';
import 'package:qms/page/TestTemplateSelectPage.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/ListPageWidget.dart';
import 'package:qms/widget/ListTopFilterWidget.dart';

///来料待检列表
class CompleteWaitTaskListPage extends StatefulWidget {
  @override
  CompleteWaitTaskListPageState createState() =>
      new CompleteWaitTaskListPageState();
}

class CompleteWaitTaskListPageState
    extends ListCommonState<CompleteWaitTaskListPage> {
  @override
  void initState() {
    super.initState();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  ///初始化筛选参数
  @protected
  void initParams() {
    params = {
      'docCat': Config.test_order_complete,

      ///检验状态
      'checkStatus': '未检',

      ///物料编码
      'invCode': '',

      ///物料名称
      'invName': '',

      ///检验员ID
      'checkerId': '',

      ///开始、结束日期
      'beginDate': '',
      'endDate': '',

      ///报工单号
      'opDocNo': '',

      ///工作中心编码
      'wcCode': '',

      ///工作中心名称
      'wcName': '',

      ///工序编码
      'opCode': '',

      ///工序名称
      'opName': '',

      ///工序行号
      //'opSeq': '',

      ///生产订单号
      'moDocNo': '',

      ///客户编码
      'cusCode': '',

      ///客户简称
      'cusName': '',

      ///批号
      'batchNumber': '',

      ///产品类型
      'protype': '',

      ///需求跟踪号
      'socode': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(Config.filterItemTypeDate, ['beginDate', 'endDate'],
          StringZh.tip_inspectionDate, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'moDocNo', StringZh.production_order, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'opDocNo', StringZh.work_orderNo, {}),
      new FilterModel(
          Config.filterItemTypeRef,
          'invCode',
          'invName',
          StringZh.inventory,
          Config.ref_inventory,
          StringZh.tip_inventory,
          true,
          new RefBasic.empty()),
      new FilterModel(
          Config.filterItemTypeRef,
          'cusCode',
          'cusName',
          StringZh.customer,
          Config.ref_customer,
          StringZh.tip_customer,
          true,
          new RefBasic.empty()),
      new FilterModel.input(
          Config.filterItemTypeInput, 'batchNumber', StringZh.batch, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'protype', StringZh.proType, {}),
      new FilterModel(
          Config.filterItemTypeRef,
          'opCode',
          'opName',
          StringZh.workStep,
          Config.ref_workStep,
          StringZh.tip_workStep,
          true,
          new RefBasic.empty()),
      new FilterModel(
          Config.filterItemTypeRef,
          'wcCode',
          'wcName',
          StringZh.workCenter,
          Config.ref_workCenter,
          StringZh.tip_workCenter,
          true,
          new RefBasic.empty()),
      new FilterModel.select(Config.filterItemTypeSingleSelect, 'checkStatus',
          StringZh.tip_testState, [
        {'value': '未检', 'text': '未检', 'isSelect': true, 'default': true},
        {'value': '已检', 'text': '已检', 'isSelect': false},
        {'value': '全部', 'text': '全部', 'isSelect': false},
      ]),
    ];
  }

  ///初始化数据
  @protected
  void getDataRequest() {
    QmsService.getQuarantineTaskList(
        context,
        {
          'pageIndex': page.toString(),
          'pageSize': Config.pageSize.toString(),
          'docCat': params['docCat'],
          'checkStatus': params['checkStatus'],
          'invCode': params['invCode'],
          'checkerId': params['checkerId'],
          'beginDate': params['beginDate'],
          'endDate': params['endDate'],
          'moDocNo': params['moDocNo'],
          'opDocNo': params['opDocNo'],
          'cusName': params['cusName'],
          'batchNumber': params['batchNumber'],
          'protype': params['protype'],
          'opCode': params['opCode'],
          'wcCode': params['wcCode'],
        },
        requestSuccessCallBack,
        requestErrorCallBack);
  }

  ///列点击事件
  _rowColumnsTap(var field, var data) {
    print(field);
    switch (field) {

      ///录入操作
      case 'luru':
        showDialog<Null>(
            context: context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new TestTemplateSelectPage(
                qty: data['canCheckQty'],
                testCat: Config.text_complete,
                docCat: Config.test_order_complete,
                invCatCode: data['invCatCode'],
                invCode: data['invCode'],
                opCode: data['opCode'],
                srcDocDetailId: data['moRoutingBillDetailId'],
                detailTitle: StringZh.completeTestOrderDetail_title,
              );
            });
        break;

      ///检验单详情
      case 'testOrderDocNo':
        break;
      default:
        break;
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBarWidget(
        title: StringZh.completeWaitTask_title,
      ),
      body: new Column(
        children: <Widget>[
          new ListTopFilterWidget(
            onPressed: () {
              showFilter();
            },
          ),
          WidgetUtil.getListRows(context, loading, dataList,
              QMSFieldConfig.completeWaitTaskListPage, _rowColumnsTap,
              isOper: true),
          new ListPageWidget(
            page: page,
            size: size,
            total: total,
            firstFun: firstFun,
            preFun: preFun,
            nextFun: nextFun,
            endFun: endFun,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
