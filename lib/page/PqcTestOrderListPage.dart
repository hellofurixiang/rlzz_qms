import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ListCommonState.dart';
import 'package:qms/page/TestOrderSamplePage.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/ListPageWidget.dart';
import 'package:qms/widget/ListTopFilterWidget.dart';

///PQC检验单列表
class PqcTestOrderListPage extends StatefulWidget {
  @override
  PqcTestOrderListPageState createState() => new PqcTestOrderListPageState();
}

class PqcTestOrderListPageState extends ListCommonState<PqcTestOrderListPage> {
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
      'docCat': Config.test_order_pqc,

      ///开始、结束日期
      'beginDate': '',
      'endDate': '',

      ///检验单号
      'docNo': '',

      ///物料编码
      'invCode': '',

      ///物料名称
      'invName': '',

      ///审核状态
      'auditStatus': '0',

      ///检验员ID
      'checkerId': '',
      'checkerName': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(
          Config.filterItemTypeDate, ['beginDate', 'endDate'], '检验日期', {}),
      new FilterModel.input(Config.filterItemTypeInput, 'docNo', '检验单号', {}),
      new FilterModel(Config.filterItemTypeRef, 'invCode', 'invName', '物料',
          Config.ref_inventory, '请选择物料', true, new RefBasic.empty()),
      new FilterModel.select(
          Config.filterItemTypeSingleSelect, 'auditStatus', '审核状态', [
        {
          'value': '',
          'text': '全部',
          'isSelect': false,
        },
        {'value': '1', 'text': '已审核', 'isSelect': false},
        {'value': '0', 'text': '待审核', 'isSelect': true, 'default': true},
      ]),
      new FilterModel(Config.filterItemTypeRef, 'checkerId', 'checkerName',
          '检验员', Config.ref_user, '请选择检验员', true, new RefBasic.empty()),
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
          'docCat': params['docCat'],
          'beginDate': params['beginDate'],
          'endDate': params['endDate'],
          'docNo': params['docNo'],
          'invCode': params['invCode'],
          'invName': params['invName'],
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

      ///检验单详情
      case 'docNo':
        NavigatorUtil.goToPage(
            context,
            new TestOrderSamplePage(
                id: data['id'],
                docNo: data['docNo'],
                docCat: Config.test_order_pqc,
                testCat: Config.text_pqc,
                title: StringZh.pqcTestOrderDetail_title),
            permissions: Config.pqc_view,
            permissionsText: StringZh.pqcTestOrderDetail_view);

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
        title: StringZh.pqcTestOrderList_title,
      ),
      body: new Column(
        children: <Widget>[
          new ListTopFilterWidget(
            onPressed: () {
              showFilter();
            },
          ),
          WidgetUtil.getListRows(context, loading, dataList,
              QMSFieldConfig.arrivalTestOrderListPage, _rowColumnsTap),
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
