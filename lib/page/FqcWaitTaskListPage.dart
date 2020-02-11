import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/modal/SelectVo.dart';
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
  FqcWaitTaskListPageState createState() => new FqcWaitTaskListPageState();
}

class FqcWaitTaskListPageState extends ListCommonState<FqcWaitTaskListPage> {
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
    params.docCat = Config.test_order_fqc;

    ///检验状态
    params.checkStatus = Config.value_n;
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
        SelectVo(Config.value_n, StringZh.unCheck, isDefault: true),
        SelectVo(Config.value_y, StringZh.checked),
        SelectVo('', StringZh.all),
      ]),
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
    searchVo.cusName = params['cusName'];
    searchVo.batchNumber = params['batchNumber'];
    searchVo.opCode = params['opCode'];
    searchVo.invCode = params['invCode'];
    searchVo.checkerId = params['checkerId'];
    searchVo.checkStatus = params['checkStatus'];
    searchVo.protype = params['protype'];
    searchVo.opDocNo = params['opDocNo'];
    searchVo.wcCode = params['wcCode'];*/
    QmsService.getQuarantineTaskList(
        context, params.toJson(), requestSuccessCallBack, requestErrorCallBack);
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
              FieldConfig.fqcWaitTaskListPage, _rowColumnsTap,
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
