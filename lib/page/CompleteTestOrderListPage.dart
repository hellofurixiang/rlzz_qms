import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/config/UserPermissionsConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/modal/SelectVo.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ListCommonState.dart';
import 'package:qms/page/TestOrderPage.dart';
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
    params.docCat = Config.test_order_complete;

    ///审核状态
    params.auditStatus = Config.value_no;
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(Config.filterItemTypeDate, ['beginDate', 'endDate'],
          StringZh.test_docNo, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'moDocNo', StringZh.production_order, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'srcDocNo', StringZh.srcDocNo, {}),
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
          Config.ref_inventory,
          StringZh.tip_customer,
          true,
          new RefBasic.empty()),
      new FilterModel.input(
          Config.filterItemTypeInput, 'batchNumber', StringZh.batch, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'socode', StringZh.soCode, {}),
      new FilterModel(
          Config.filterItemTypeRef,
          'opCode',
          'opName',
          StringZh.workStep,
          Config.ref_workStep,
          StringZh.tip_workStep,
          true,
          new RefBasic.empty()),
      new FilterModel.select(Config.filterItemTypeSingleSelect, 'auditStatus',
          StringZh.tip_testState, [
        SelectVo('', StringZh.all),
        SelectVo(Config.value_yes, StringZh.is_audit),
        SelectVo(Config.value_no, StringZh.not_audit, isDefault: true),
      ]),
      new FilterModel(
          Config.filterItemTypeRef,
          'checkerId',
          'checkerName',
          StringZh.checker,
          Config.ref_user,
          StringZh.tip_checker,
          true,
          new RefBasic.empty()),
    ];
  }

  ///初始化数据
  @protected
  void getDataRequest() {
    /*GeneralVo searchVo = GeneralVo.empty();
    searchVo.pageIndex = page;
    searchVo.pageSize = Config.pageSize;
    searchVo.docCat = params['docCat'];
    searchVo.beginDate = params['beginDate'];
    searchVo.endDate = params['endDate'];
    searchVo.moDocNo = params['moDocNo'];
    searchVo.srcDocNo = params['srcDocNo'];
    searchVo.cusName = params['cusName'];
    searchVo.batchNumber = params['batchNumber'];
    searchVo.socode = params['socode'];
    searchVo.opCode = params['opCode'];
    searchVo.invCode = params['invCode'];
    searchVo.invName = params['invName'];
    searchVo.auditStatus = params['auditStatus'];
    searchVo.checkerId = params['checkerId'];*/
    params.pageIndex = page;
    params.pageSize = Config.pageSize;
    QmsService.getTestOrderList(
        context, params.toJson(), requestSuccessCallBack, requestErrorCallBack);
  }

  ///列点击事件
  _rowColumnsTap(var field, var data) {
    print(field);
    switch (field) {

      ///检验单详情
      case 'docNo':
        NavigatorUtil.goToPage(
            context,
            new TestOrderPage(
                id: data['id'],
                docNo: data['docNo'],
                docCat: Config.test_order_complete,
                testCat: Config.text_fqc,
                title: StringZh.completeTestOrderDetail_title),
            permissions: UserPermissionsConfig.complete_view,
            permissionsText: StringZh.completeTestOrderDetail_view);

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
              FieldConfig.completeTestOrderListPage, _rowColumnsTap),
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
