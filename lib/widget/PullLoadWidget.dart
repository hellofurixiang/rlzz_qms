import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

///通用下上刷新控件
class PullLoadWidget extends StatefulWidget {
  ///表格模式
  final bool isTable;

  ///item渲染
  final IndexedWidgetBuilder itemBuilder;

  ///加载更多回调
  final RefreshCallback onLoadMore;

  ///下拉刷新回调
  final RefreshCallback onRefresh;

  ///控制器，比如数据和一些配置
  final PullLoadWidgetControl control;

  final Key refreshKey;

  ///加载控件
  final Widget loadingWidget;

  PullLoadWidget(
      {@required this.control,
      @required this.itemBuilder,
      @required this.onRefresh,
      @required this.onLoadMore,
      @required this.refreshKey,
      this.isTable: false,
      this.loadingWidget});

  @override
  _PullLoadWidgetState createState() => _PullLoadWidgetState(this.control,
      this.itemBuilder, this.onRefresh, this.onLoadMore, this.refreshKey);
}

class _PullLoadWidgetState extends State<PullLoadWidget> {
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRefresh;

  final Key refreshKey;

  PullLoadWidgetControl control;

  _PullLoadWidgetState(this.control, this.itemBuilder, this.onRefresh,
      this.onLoadMore, this.refreshKey);

  @override
  void initState() {
    super.initState();

    if (control.isRefreshFirst) {
      onRefresh();
    }
  }

  ///根据配置状态返回实际列表数量
  _getListCount() {
    return control.dataList.length == 0 ? 1 : control.dataList.length;
  }

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      if (this.control.needLoadMore) {
        this.onLoadMore?.call();
      }
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 1), () {
      onRefresh();
    });
  }

  Widget _itemBuilder(int index) {
    if (control.dataList.length == 0) {
      return widget.loadingWidget ?? WidgetUtil.buildEmpty(context);
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return itemBuilder(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Refresh(
      //scrollController: _scrollController,
      onFooterRefresh: onFooterRefresh,
      onHeaderRefresh: onHeaderRefresh,
      childBuilder: (BuildContext context,
          {ScrollController controller, ScrollPhysics physics}) {
        return new Container(
            //color: Colors.red,
            child: new ListView.builder(
                padding: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 2.0),
                itemCount: _getListCount(),
                controller: controller,
                physics: physics,
                itemBuilder: (context, index) => _itemBuilder(index)));
      },
    );
  }
}

class PullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = new List();

  ///是否需要加载更多
  bool needLoadMore = true;

  ///是否需要头部
  bool needHeader = false;

  ///是否需要第一次进入自动刷新
  bool isRefreshFirst = true;
}
