import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/widget/ListFilterWidget.dart';

///上下拉刷新列表的通用State
abstract class ListCommonState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  List dataList = new List();
  int page = 1;
  bool isMore = true;

  bool loading = true;

  ///默认筛选参数
  Map<String, String> params = {};

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
  initParams() {}

  @protected
  initFilterModelList() {}

  @protected
  getDataRequest() {}

  @protected
  refreshInfo() {}

  @protected
  void requestSuccessCallBack(res) {
    if (page == 1) {
      setState(() {
        loading = false;
      });
    }
    if (res.length == 0) {
      if (page == 1) {
        setState(() {
          dataList = res;
        });
        refreshInfo();
        Fluttertoast.showToast(msg: '暂时没有数据哟～', timeInSecForIos: 3);
        return;
      }
      page--;
      Fluttertoast.showToast(msg: '最后一页了，没有数据了哟～', timeInSecForIos: 3);
      return;
    }
    setState(() {
      dataList = res;
    });
    refreshInfo();
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
    CommonUtil.getFilterParams(itemList, params);
    getDataRequest();
  }

  ///重置筛选参数
  void resetFilterParams() {
    initParams();
    initFilterModelList();
    showFilter();
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
    page++;
    getDataRequest();
  }

  ///刷新
  @protected
  void refreshFun() {
    page = 1;
    getDataRequest();
  }

  ///显示筛选
  void showFilter() {
    CommonUtil.getShowFilterParams(itemList, params);

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
