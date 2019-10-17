import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/ListCommonState.dart';
import 'package:qms/widget/AppBarWidget.dart';
import 'package:qms/widget/ListTopFilterWidget.dart';

class ArrivalSupplierReport extends StatefulWidget {
  @override
  ArrivalSupplierReportState createState() => ArrivalSupplierReportState();
}

class ArrivalSupplierReportState extends ListCommonState<ArrivalSupplierReport>
    with SingleTickerProviderStateMixin {
  ///面板切换控件
  TabController tabController;

  ///报表宽、高
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  ///初始化筛选参数
  @protected
  void initParams() {
    params = {
      'beginDate': '',
      'supplierCode': '',
      'supplierName': '',
      'invCatCode': '',
      'invCatName': '',
      'invCode': '',
      'invName': '',
    };
  }

  ///初始化筛选控件数据
  @protected
  void initFilterModelList() {
    itemList = [
      new FilterModel.date(
          Config.filterItemTypeDate, ['beginDate'], '检验日期', {}),
      new FilterModel(Config.filterItemTypeRef, 'supplierCode', 'supplierName',
          '供应商', Config.ref_supplier, '请选择供应商', true, new RefBasic.empty()),
      new FilterModel(Config.filterItemTypeRef, 'invCatCode', 'invCatName',
          '物料分类', Config.ref_invCat, '请选择物料分类', true, new RefBasic.empty()),
      new FilterModel(Config.filterItemTypeRef, 'invCode', 'invName', '物料',
          Config.ref_inventory, '请选择物料', true, new RefBasic.empty()),
    ];
  }

  ///初始化数据beginDate、supplierCode、invCatCode、invCode
  @protected
  void getDataRequest() {
    QmsService.getArrivalTestOrderStatisticalForSupplier(
        context,
        {
          'beginDate': params['beginDate'],
          'supplierCode': params['supplierCode'],
          'invCatCode': params['invCatCode'],
          'invCode': params['invCode'],
        },
        requestSuccessCallBack,
        requestErrorCallBack);
  }

  MethodChannel _channel;

  void onMyViewCreated(int id) {
    _channel = new MethodChannel('${Config.chartViewTypeId}_$id');
    //refreshInfo();
  }

  @protected
  Future<void> refreshInfo() async {
    assert(dataList != null);
    print(dataList);
    return _channel.invokeMethod('refresh', dataList);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);
    height = CommonUtil.getScreenHeight(context) - 95;

    return new DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: new Scaffold(
        appBar: new AppBarWidget(
          title: StringZh.arrivalSupplierReportTitle,
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            tabController.animateTo(tabController.index == 0 ? 1 : 0);
          },
          child: Icon(Icons.blur_circular),
        ),
        body: new Column(
          children: <Widget>[
            new ListTopFilterWidget(
              onPressed: () {
                showFilter();
              },
            ),
            //WidgetUtil.getDivider(height: 0.5, color: RLZZColors.mainColor),
            loading
                ? new Expanded(
                    child: WidgetUtil.getLoadingWidget(StringZh.loading))
                : new Expanded(
                    child: new TabBarView(
                      controller: tabController,
                      children: [
                        new ListView(
                          children: <Widget>[
                            new Container(
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    color: Colors.white,
                                    height: height,
                                    width: width,
                                    child: AndroidView(
                                      viewType: Config.chartViewTypeId,
                                      creationParams: {
                                        "list": dataList,
                                        "reportType":
                                            Config.arrivalSupplierReport,
                                      },
                                      creationParamsCodec:
                                          const StandardMessageCodec(),
                                      onPlatformViewCreated: onMyViewCreated,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Column(
                          children: <Widget>[
                            new Container(
                              child: new Expanded(
                                child: new ListView(
                                  children: <Widget>[
                                    new SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: new Column(
                                        children: <Widget>[
                                          new Table(
                                              columnWidths: WidgetUtil
                                                  .getTableColumnWidth(
                                                      QMSFieldConfig
                                                          .arrivalSupplierReport),
                                              children: <TableRow>[
                                                new TableRow(
                                                  children: WidgetUtil
                                                      .renderTableHeadColumnsByConfig(
                                                          QMSFieldConfig
                                                              .arrivalSupplierReport),
                                                )
                                              ]),
                                          new Table(
                                            columnWidths:
                                                WidgetUtil.getTableColumnWidth(
                                                    QMSFieldConfig
                                                        .arrivalSupplierReport),
                                            children: WidgetUtil
                                                .renderTableRowColumnsByConfigForReport(
                                                    context,
                                                    dataList,
                                                    QMSFieldConfig
                                                        .arrivalSupplierReport),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
