import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/config/UserPermissionsConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ListCommonState.dart';
import 'package:qms/page/TestOrderPage.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/ListPageWidget.dart';
import 'package:qms/widget/ListTopFilterWidget.dart';

///来料检验单列表
class ArrivalTestOrderListPage extends StatefulWidget {
  @override
  ArrivalTestOrderListPageState createState() =>
      new ArrivalTestOrderListPageState();
}

class ArrivalTestOrderListPageState
    extends ListCommonState<ArrivalTestOrderListPage> {
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
      'docCat': Config.test_order_arrival,

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
      'auditStatus': Config.value_no,

      ///检验员ID
      'checkerId': '',
      'checkerName': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(Config.filterItemTypeDate, ['beginDate', 'endDate'],
          StringZh.test_docDate, {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'docNo', StringZh.test_docNo, {}),
      new FilterModel(
          Config.filterItemTypeRef,
          'invCode',
          'invName',
          StringZh.inventory,
          Config.ref_inventory,
          StringZh.tip_inventory,
          true,
          new RefBasic.empty()),
      new FilterModel.select(Config.filterItemTypeSingleSelect, 'auditStatus',
          StringZh.tip_auditState, [
        {
          'value': '',
          'text': StringZh.all,
          'isSelect': false,
        },
        {
          'value': Config.value_yes,
          'text': StringZh.is_audit,
          'isSelect': false
        },
        {
          'value': Config.value_no,
          'text': StringZh.not_audit,
          'isSelect': true,
          'default': true
        },
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
            new TestOrderPage(
                id: data['id'],
                docNo: data['docNo'],
                docCat: Config.test_order_arrival,
                testCat: Config.text_iqc,
                title: StringZh.arrivalTestOrderDetail_title),
            permissions: UserPermissionsConfig.arrival_view,
            permissionsText: StringZh.arrivalTestOrderDetail_view);

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
        title: StringZh.arrivalTestOrderList_title,
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
          /*loading
              ? new Expanded(
                  child: WidgetUtil.getLoadingWidget(StringZh.loading))
              : new Expanded(
                  child: new ListView(
                    children: <Widget>[
                      new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: new Column(
                          children: <Widget>[
                            new Table(
                              columnWidths: WidgetUtil.getTableColumnWidth(
                                  QMSFieldConfig.arrivalTestOrderListPage),
                              children: <TableRow>[
                                new TableRow(
                                  children: WidgetUtil
                                      .renderTableHeadColumnsByConfig2(
                                          QMSFieldConfig
                                              .arrivalTestOrderListPage),
                                )
                              ],
                            ),
                            new Table(
                              columnWidths: WidgetUtil.getTableColumnWidth(
                                  QMSFieldConfig.arrivalTestOrderListPage),
                              children:
                                  WidgetUtil.renderTableRowColumnsByConfig2(
                                      context,
                                      dataList,
                                      QMSFieldConfig.arrivalTestOrderListPage,
                                      _rowColumnsTap),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/
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
