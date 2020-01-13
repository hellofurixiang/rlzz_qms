import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/modal/GeneralVo.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/widget/ListFilterWidget.dart';

///上下拉刷新列表的通用State
abstract class ListCommonState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  List dataList = new List();
  int page = 1;
  int size = Config.pageSize;
  int total = 0;
  bool isMore = true;

  bool loading = true;

  ///默认筛选参数
  GeneralVo params = GeneralVo.empty();

  ///筛选项目、初始化筛选参数参照
  List<FilterModel> itemList = new List();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      //refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  @protected
  initParams() {
  }

  @protected
  initFilterModelList() {}

  @protected
  getDataRequest() {}

  @protected
  void requestSuccessCallBack(res) {
    if (page == 1 && res.length == 0) {
      setState(() {
        total = 0;
        dataList = res['resBody'];
      });
      Fluttertoast.showToast(msg: StringZh.noDataTip, timeInSecForIos: 3);
      return;
    }

    /*if(page == getEndPage()) {
      page--;
      Fluttertoast.showToast(msg: '最后一页了，没有数据了哟～', timeInSecForIos: 3);
      return;
    }*/
    setState(() {
      loading = false;
      total = res['total'];
      dataList = res['resBody'];
    });
  }

  @protected
  void requestErrorCallBack(String errorMsg) async {
    if (page > 1) {
      page--;
    }
    setState(() {
      loading = false;
    });
    Fluttertoast.showToast(msg: errorMsg, timeInSecForIos: 3);
  }

  ///筛选回调
  void getFilterParams() {
    Map<String, dynamic> requestParams =
        CommonUtil.getFilterParams(itemList, params.toJson());
    params = GeneralVo.fromJson(requestParams);
    getDataRequest();
  }

  ///重置筛选参数
  void resetFilterParams() {
    params = GeneralVo.empty();
    initParams();
    initFilterModelList();
    showFilter();
  }

  ///首页页
  @protected
  void firstFun() {
    page = 1;
    getDataRequest();
  }

  ///上一页
  @protected
  void preFun() {
    if (page == 1) {
      Fluttertoast.showToast(msg: StringZh.first_page_tip, timeInSecForIos: 3);
      return;
    }
    page--;
    getDataRequest();
  }

  ///下一页
  @protected
  void nextFun() {
    if (page == getEndPage()) {
      Fluttertoast.showToast(msg: StringZh.end_page_tip, timeInSecForIos: 3);
      return;
    }
    page++;
    getDataRequest();
  }

  ///末页
  @protected
  void endFun() {
    page = getEndPage();
    getDataRequest();
  }

  int getEndPage() {
    ///取余
    int yu = total % size;

    ///取整
    int zheng = total ~/ size;

    print('yu:$yu');
    print('zheng:$zheng');

    int newPage = zheng;
    if (yu > 0) {
      newPage = newPage + 1;
    }
    return newPage;
  }

  ///刷新
  @protected
  void refreshFun() {
    page = 1;
    getDataRequest();
  }

  ///显示筛选
  void showFilter() {
    CommonUtil.getShowFilterParams(itemList, params.toJson());

    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new ListFilterWidget(
            callBack: () {
              getFilterParams();
            },
            itemList: itemList,
            resetCallBack: () {
              setState(() {
                resetFilterParams();
              });
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    initParams();
    initFilterModelList();
    getDataRequest();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
