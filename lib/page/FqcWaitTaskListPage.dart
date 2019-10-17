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

///FQC待检列表
class FqcWaitTaskListPage extends StatefulWidget {
  @override
  FqcWaitTaskListPageState createState() =>
      new FqcWaitTaskListPageState();
}

class FqcWaitTaskListPageState
    extends ListCommonState<FqcWaitTaskListPage> {
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
      'docCat': Config.test_order_fqc,

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
      new FilterModel.date(
          Config.filterItemTypeDate, ['beginDate', 'endDate'], '报检日期', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'moDocNo', '生产订单', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'opDocNo', '报工单号', {}),
      new FilterModel(Config.filterItemTypeRef, 'invCode', 'invName', '物料',
          Config.ref_inventory, '请选择物料', true, new RefBasic.empty()),
      new FilterModel(Config.filterItemTypeRef, 'cusCode', 'cusName', '客户',
          Config.ref_customer, '请选择客户', true, new RefBasic.empty()),
      new FilterModel.input(
          Config.filterItemTypeInput, 'batchNumber', '批号', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'protype', '产品类型', {}),
      new FilterModel(Config.filterItemTypeRef, 'opCode', 'opName', '工序',
          Config.ref_workStep, '请选择工序', true, new RefBasic.empty()),
      new FilterModel(Config.filterItemTypeRef, 'wcCode', 'wcName', '工作中心',
          Config.ref_workCenter, '请选择工作中心', true, new RefBasic.empty()),
      new FilterModel.select(
          Config.filterItemTypeSingleSelect, 'checkStatus', '检验状态', [
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
                testCat: Config.text_fqc,
                docCat: Config.test_order_fqc,
                invCatCode: data['invCatCode'],
                invCode: data['invCode'],
                opCode: data['opCode'],
                srcDocDetailId: data['moRoutingBillDetailId'],
                detailTitle: StringZh.fqcTestOrderDetail_title,
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
        title: StringZh.fqcWaitTask_title,
      ),
      body: new Column(
        children: <Widget>[
          new ListTopFilterWidget(
            onPressed: () {
              showFilter();
            },
          ),
          WidgetUtil.getListRows(context, loading, dataList,
              QMSFieldConfig.fqcWaitTaskListPage, _rowColumnsTap,
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
