import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/PullLoadWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

///上下拉刷新列表的通用State
abstract class RefListCommonState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  int page = 1;

  final List dataList = new List();

  Widget loadingWidget = new Center(
    child: new Container(
      width: 50.0,
      height: 50.0,
      child: new CupertinoActivityIndicator(
        radius: 25.0,
      ),
    ),
  );

  final PullLoadWidgetControl pullLoadWidgetControl =
      new PullLoadWidgetControl();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      //refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  @protected
  resolveRefreshResult(res) {
    if (res != null && res.length == 0) {
      loadingWidget = WidgetUtil.buildEmpty(context);
      setState(() {
        pullLoadWidgetControl.dataList.clear();
      });
    }
    if (res != null && res.length > 0) {
      pullLoadWidgetControl.dataList.clear();
      setState(() {
        pullLoadWidgetControl.dataList.addAll(res);
      });
    }
  }

  @protected
  resolveLoadMoreResult(res) {
    if (res != null && res.length > 0) {
      setState(() {
        pullLoadWidgetControl.dataList.addAll(res);
      });
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    await requestRefresh();
    return null;
  }

  @protected
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    await requestLoadMore();

    return null;
  }

  @protected
  resolveDataResult(res) {
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (res != null && res.length == Config.pageSize);
    });
  }

  @protected
  clearData() {
    setState(() {
      pullLoadWidgetControl.dataList.clear();
    });
  }

  ///请求数据异常
  @protected
  requestErrorCallBack(String errorMsg) async {
    Fluttertoast.showToast(msg: errorMsg, timeInSecForIos: 3);
    isLoading = false;
  }

  ///下拉刷新数据
  @protected
  requestRefresh() async {}

  ///上拉更多请求数据
  @protected
  requestLoadMore() async {}

  ///是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst => true;

  ///是否需要头部
  @protected
  bool get needHeader => false;

  ///是否包含全部
  @protected
  bool get hasAll => false;

  ///是否需要保持
  @override
  bool get wantKeepAlive => true;

  List get getDataList => dataList;

  @override
  void initState() {
    super.initState();
    pullLoadWidgetControl.needHeader = needHeader;
    pullLoadWidgetControl.isRefreshFirst = isRefreshFirst;
    pullLoadWidgetControl.dataList = getDataList;
    if (pullLoadWidgetControl.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }
}
