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

///完工检验单列表
class CompleteTestOrderListPage extends StatefulWidget {
  @override
  CompleteTestOrderListPageState createState() =>
      new CompleteTestOrderListPageState();
}

class CompleteTestOrderListPageState
    extends ListCommonState<CompleteTestOrderListPage> {
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
      'docCat': 'default',

      ///开始、结束日期
      'beginDate': '',
      'endDate': '',

      ///生产订单号
      'moDocNo': '',

      ///来源单据号
      'srcDocNo': '',

      ///物料编码
      'invCode': '',

      ///物料名称
      'invName': '',

      ///客户编码
      'cusCode': '',

      ///客户简称
      'cusName': '',

      ///批号
      'batchNumber': '',

      ///需求跟踪号
      'socode': '',

      ///工序编码
      'opCode': '',

      ///工序名称
      'opName': '',

      ///审核状态
      'auditStatus': '0',

      ///检验员ID
      'checkerId': '',

      ///检验员名称
      'checkerName': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(
          Config.filterItemTypeDate, ['beginDate', 'endDate'], '检验日期', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'moDocNo', '生产订单', {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'srcDocNo', '来源单据号', {}),
      new FilterModel(Config.filterItemTypeRef, 'invCode', 'invName', '物料',
          Config.ref_inventory, '请选择物料', true, new RefBasic.empty()),
      new FilterModel(Config.filterItemTypeRef, 'cusCode', 'cusName', '客户',
          Config.ref_inventory, '请选择客户', true, new RefBasic.empty()),
      new FilterModel.input(
          Config.filterItemTypeInput, 'batchNumber', '批号', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'socode', '需求跟踪号', {}),
      new FilterModel(Config.filterItemTypeRef, 'opCode', 'opName', '工序',
          Config.ref_workStep, '请选择工序', true, new RefBasic.empty()),
      new FilterModel.select(
          Config.filterItemTypeSingleSelect, 'auditStatus', '检验状态', [
        {'value': '', 'text': '全部', 'isSelect': false},
        {'value': '1', 'text': '已审核', 'isSelect': false},
        {'value': '0', 'text': '待审核', 'isSelect': true, 'default': true},
      ]),
      new FilterModel(Config.filterItemTypeRef, 'checkerId', 'checkerName',
          '质检员', Config.ref_user, '请选择质检员', true, new RefBasic.empty()),
    ];
  }

  ///初始化数据
  @protected
  void getDataRequest() {
    QmsService.getTestOrderList(
        context,
        {
          'pageIndex': page.toString(),
          'pageSize': Config.pageSize.toString(),
          'beginDate': params['beginDate'],
          'endDate': params['endDate'],
          'docCat': params['docCat'],
          'moDocNo': params['moDocNo'],
          'srcDocNo': params['srcDocNo'],
          'invCode': params['invCode'],
          'invName': params['invName'],
          'cusName': params['cusName'],
          'batchNumber': params['batchNumber'],
          'socode': params['socode'],
          'opCode': params['opCode'],
          'auditStatus': params['auditStatus'],
          'checkerId': params['checkerId'],
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
                testCat: '来料检验',
                invCatCode: data['invCatCode'],
                invCode: data['invCode'],
                srcDocDetailId: data['moRoutingBillDetailId'],
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
        title: StringZh.completeTestOrderList_title,
      ),
      body: new Column(
        children: <Widget>[
          new ListTopFilterWidget(
            onPressed: () {
              showFilter();
            },
          ),
          WidgetUtil.getListRows(context, loading, dataList,
              QMSFieldConfig.completeTestOrderListPage, _rowColumnsTap),
          new ListPageWidget(
            page: page.toString(),
            preFun: preFun,
            nextFun: nextFun,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
