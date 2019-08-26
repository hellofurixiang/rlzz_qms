import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/net/NetUtil.dart';
import 'package:qms/widget/ListItemWidget.dart';
import 'package:qms/widget/PullLoadWidget.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/common/modal/RefBasic.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/RefListCommonState.dart';

///基础档案数据参照
class RefBasicWidget extends StatefulWidget {
  final FilterModel filterModel;
  final List<FilterModel> itemList;

  final Function callBack;

  const RefBasicWidget({
    Key key,
    @required this.callBack,
    @required this.filterModel,
    this.itemList,
  }) : super(key: key);

  @override
  RefBasicWidgetState createState() => new RefBasicWidgetState();
}

class RefBasicWidgetState extends RefListCommonState<RefBasicWidget> {
  @override
  void initState() {
    super.initState();
    selectData = new RefBasic(
        '', widget.filterModel.hasAll ? '全部' : '', null, null, null);
  }

  ///占屏幕宽度
  double width;

  var urls = [
    {'type': Config.ref_supplier, 'url': '/getSupplierList', 'title': '供应商'},
    {'type': Config.ref_inventory, 'url': '/getInventoryList', 'title': '物料'},
    {
      'type': Config.ref_invCat,
      'url': '/getInventoryCategoryList',
      'title': '物料分类'
    },
    {'type': Config.ref_customer, 'url': '/getCustomerList', 'title': '客户'},
    {
      'type': Config.ref_workCenter,
      'url': '/getWorkCenterList',
      'title': '工作中心'
    },
    {'type': Config.ref_workStep, 'url': '/getWorkStepList', 'title': '工序'},
    {'type': Config.ref_user, 'url': '/api/user/search', 'title': '用户'},
  ];

  ///搜索条件
  String searchText = '';

  ///选中数据
  RefBasic selectData;

  ///初始化数据
  void getDataRequest() {
    if (null == widget.filterModel.refFlag) {
      isLoading = false;
      return;
    }

    Map<String, String> params = {
      'arcCode': searchText,
      'arcName': '', //searchController.text,

      ///页签，从1开始
      'pageIndex': page.toString(),

      ///单页请求条数，默认为10
      'pageSize': Config.pageSize.toString()
    };

    var url = Config.qmsApiUrl;

    ///=============质检系统=============
    if (widget.filterModel.refFlag == Config.ref_workCenter ||
        widget.filterModel.refFlag == Config.ref_workStep) {
      url = Config.qmsApiUrl;
    }
    if (Config.ref_user == widget.filterModel.refFlag) {
      url = Config.bossApiUrl;

      params['size'] = Config.pageSize.toString();
    }

    urls.forEach((v) {
      if (v['type'] == widget.filterModel.refFlag) {
        url += v['url'];
        switch (widget.filterModel.refFlag) {

          ///用户
          case Config.ref_user:
            params['closed'] = '0';
            break;
        }
      }
    });

    ///关联参照
    String associated = widget.filterModel.associated;

    if (null != associated) {
      for (FilterModel fm in widget.itemList) {
        ///关联参照字段编码与关联参照标示相同则追加筛选条件
        if (fm.refFlag == associated) {
          params[fm.itemCode] = fm.initParam.arcCode;
          break;
        }
      }
    }

    return NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: requestErrorCallBack);
  }

  void successCallBack(res) {
    List<RefBasic> returnList = new List();

    ///操作人员做特殊处理
    if (widget.filterModel.refFlag == Config.ref_user) {
      res = res['list'];
    }

    for (var value in res) {
      ///=============质检系统=============
      if (widget.filterModel.refFlag == Config.ref_workCenter) {
        value['arcCode'] = value['wcCode'];
        value['arcName'] = value['wcName'];
      }
      if (widget.filterModel.refFlag == Config.ref_workStep) {
        value['arcCode'] = value['opCode'];
        value['arcName'] = value['opName'];
      }

      if (widget.filterModel.refFlag == Config.ref_user) {
        value['arcCode'] = value['account'];
        value['arcName'] = value['name'];
      }

      RefBasic refBasic = new RefBasic.fromJson(value);

      ///比较选中编码
      refBasic.isSelect =
          refBasic.arcCode == widget.filterModel.initParam.arcCode
              ? true
              : false;
      if (refBasic.isSelect) {
        selectData = refBasic;
      }
      returnList.add(refBasic);
    }
    if (page == 1) {
      if (widget.filterModel.hasAll) {
        RefBasic item = new RefBasic('', '全部', null, null, null);

        ///比较选中编码
        item.isSelect =
            item.arcCode == widget.filterModel.initParam.arcCode ? true : false;
        returnList.insert(0, item);
      }
      resolveRefreshResult(returnList);
    } else {
      resolveLoadMoreResult(returnList);
    }
    resolveDataResult(returnList);
    isLoading = false;
  }

  ///下拉刷新数据
  @protected
  requestRefresh() async {
    getDataRequest();
  }

  ///上拉更多请求数据
  @protected
  requestLoadMore() async {
    getDataRequest();
  }

  ///是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst => true;

  ///是否需要头部
  @protected
  bool get needHeader => true;

  @protected
  bool get hasAll => widget.filterModel.hasAll;

  Widget _renderItem(int index) {
    if (pullLoadWidgetControl.dataList.length == 0) {
      return null;
    }
    RefBasic data = pullLoadWidgetControl.dataList[index];

    return new ListItemWidget(
      onTap: () {
        selectData = data;

        setState(() {
          pullLoadWidgetControl.dataList.forEach((item) {
            item.isSelect = false;
          });
          pullLoadWidgetControl.dataList[index].isSelect = true;
        });
      },
      child: new Column(children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              width: width * 0.3,
              child: new Text(
                data.arcCode,
                style: new TextStyle(fontSize: RLZZConstant.normalTextSize),
              ),
            ),
            new Expanded(
              child: new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  data.arcName,
                  style: new TextStyle(fontSize: RLZZConstant.normalTextSize),
                ),
              ),
            ),
            data.isSelect
                ? new Container(
                    alignment: Alignment.centerRight,
                    child: new Icon(
                      Icons.done,
                      color: RLZZColors.mainColor,
                      size: 20.0,
                    ),
                  )
                : new Container(),
          ],
        ),
      ]),
    );
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (CommonUtil.checkIsLargeScreen(context)) {
      width = CommonUtil.getScreenWidth(context) * 0.6;
    } else {
      width = CommonUtil.getScreenWidth(context) * 0.3;
    }

    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Row(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          new Expanded(
            child: new Container(
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        border: Border(
                            bottom:
                                new BorderSide(color: RLZZColors.darkGrey))),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(
                            Icons.keyboard_arrow_left,
                            color: RLZZColors.darkDarkGrey,
                          ),
                          onPressed: () {
                            //_slideKey.currentState.changeOffstage();
                            Navigator.pop(context);
                          },
                        ),
                        new Text(
                          widget.filterModel.title,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: RLZZColors.mainColor,
                            fontSize: RLZZConstant.normalTextSize,
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            if (null != widget.callBack)
                              widget.callBack(selectData);
                            Navigator.pop(context);
                            //_slideKey.currentState.changeOffstage();
                          },
                          child: new Container(
                            width: 45.0,
                            child: new Text(
                              StringZh.app_ok,
                              style: new TextStyle(
                                fontSize: RLZZConstant.normalTextSize,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.all(8.0),
                            child: new InputWidget(
                              isSearch: true,
                              onSubmitted: (v) {
                                searchText = v;
                                handleRefresh();
                              },
                              isCenter: true,
                              clearCallBack: () {
                                handleRefresh();
                              },
                            ),
                          ),
                          WidgetUtil.getDivider(
                              height: 1.0, color: RLZZColors.dividerColor),
                          new Expanded(
                            child: PullLoadWidget(
                              control: pullLoadWidgetControl,
                              itemBuilder: (BuildContext context, int index) =>
                                  _renderItem(index),
                              onRefresh: handleRefresh,
                              onLoadMore: onLoadMore,
                              refreshKey: refreshIndicatorKey,
                              loadingWidget: loadingWidget,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
