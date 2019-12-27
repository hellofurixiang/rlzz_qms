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

///IPQC待检列表
class IpqcWaitTaskListPage extends StatefulWidget {
  @override
  IpqcWaitTaskListPageState createState() => new IpqcWaitTaskListPageState();
}

class IpqcWaitTaskListPageState extends ListCommonState<IpqcWaitTaskListPage> {
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
      'docCat': Config.test_order_ipqc,

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
      new FilterModel.date(Config.filterItemTypeDate, ['beginDate', 'endDate'],
          StringZh.tip_inspectionDate, {}),
      new FilterModel.input(Config.filterItemTypeInput, 'arrivalDocNo',
          StringZh.tip_arrivalDocNo, {}),
      new FilterModel(
          Config.filterItemTypeRef,
          'invCode',
          'invName',
          StringZh.inventory,
          Config.ref_inventory,
          StringZh.tip_inventory,
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
                qty: '2',
                //data['canCheckQty'],
                testCat: Config.text_ipqc,
                docCat: Config.test_order_ipqc,
                invCatCode: data['invCatCode'],
                invCode: data['invCode'],
                srcDocDetailId: data['arrivalDetailId'],
                detailTitle: StringZh.ipqcTestOrderDetail_title,
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
        title: StringZh.ipqcWaitTask_title,
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
                QMSFieldConfig.ipqcWaitTaskListPage, _rowColumnsTap,
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
