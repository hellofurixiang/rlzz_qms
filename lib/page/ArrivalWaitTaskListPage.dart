import 'package:flutter/material.dart';
import 'package:fluttertoast/generated/i18n.dart';
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
class ArrivalWaitTaskListPage extends StatefulWidget {
  @override
  ArrivalWaitTaskListPageState createState() =>
      new ArrivalWaitTaskListPageState();
}

class ArrivalWaitTaskListPageState
    extends ListCommonState<ArrivalWaitTaskListPage> {
  @override
  void initState() {
    super.initState();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  @override
  // ignore: must_call_super
  void didUpdateWidget(var oldWidget) {
    super.didUpdateWidget(oldWidget);

    print(111);
  }

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    super.didChangeDependencies();

    print(2222);
  }

  ///初始化筛选参数
  @protected
  void initParams() {
    params = {
      'docCat': Config.test_order_arrival,

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

      ///到货单号
      'arrivalDocNo': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(
          Config.filterItemTypeDate, ['beginDate', 'endDate'], '报检日期', {}),
      new FilterModel.input(
          Config.filterItemTypeInput, 'arrivalDocNo', '到货单号', {}),
      new FilterModel(Config.filterItemTypeRef, 'invCode', 'invName', '物料',
          Config.ref_inventory, '请选择物料', true, new RefBasic.empty()),
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
          'arrivalDocNo': params['arrivalDocNo']
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
                testCat: Config.text_arrival,
                docCat: Config.test_order_arrival,
                invCatCode: data['invCatCode'],
                invCode: data['invCode'],
                srcDocDetailId: data['arrivalDetailId'],
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
        title: StringZh.arrivalWaitTask_title,
      ),
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new ListTopFilterWidget(
              onPressed: () {
                showFilter();
              },
            ),
            WidgetUtil.getListRows(context, loading, dataList,
                QMSFieldConfig.arrivalWaitTaskListPage, _rowColumnsTap,
                isOper: true),
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
                                    QMSFieldConfig.arrivalWaitTaskListPage),
                                children: <TableRow>[
                                  new TableRow(
                                    children: WidgetUtil
                                        .renderTableHeadColumnsByConfig2(
                                            QMSFieldConfig
                                                .arrivalWaitTaskListPage,
                                            isOper: true),
                                  )
                                ],
                              ),
                              new Table(
                                columnWidths: WidgetUtil.getTableColumnWidth(
                                    QMSFieldConfig.arrivalWaitTaskListPage),
                                children:
                                    WidgetUtil.renderTableRowColumnsByConfig2(
                                        context,
                                        dataList,
                                        QMSFieldConfig.arrivalWaitTaskListPage,
                                        _rowColumnsTap,
                                        isOper: true),
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
