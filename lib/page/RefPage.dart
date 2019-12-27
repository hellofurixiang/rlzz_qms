import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';
import 'package:qms/widget/PullLoadWidget.dart';
import 'package:qms/widget/RefListCommonState.dart';

///参照
class RefPage extends StatefulWidget {
  final String title;
  final String url;

  final String arcCode;

  ///确定方法
  final Function okFun;

  RefPage({
    Key key,
    this.arcCode,
    @required this.okFun,
    @required this.url,
    @required this.title,
  }) : super(key: key);

  @override
  RefPageState createState() => RefPageState();
}

class RefPageState extends RefListCommonState<RefPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  ///页面宽度
  double width;

  ///初始化数据
  void getDataRequest() {
    //findBadReasonRef';findMeasuringToolRef

    QmsService.getRefList(context, widget.url, {}, (res) {
      for (int i = 0; i < res.length; i++) {
        if (res[i]['arcCode'].toString() == widget.arcCode) {
          res[i]['isSelect'] = true;
          break;
        }
      }

      if (page == 1) {
        resolveRefreshResult(res);
      } else {
        resolveLoadMoreResult(res);
      }
      resolveDataResult(res);
      isLoading = false;
    }, requestErrorCallBack);
  }

  _clickFunOK() {
    var obj;
    for (int i = 0; i < dataList.length; i++) {
      var v = dataList[i];
      if (null != v['isSelect'] && v['isSelect']) {
        obj = v;
        break;
      }
    }

    if (null == obj) {
      Fluttertoast.showToast(
          msg: StringZh.tip_selectTestTemplate, timeInSecForIos: 3);
      return;
    }
    Navigator.pop(context);
    widget.okFun(obj);
  }

  _renderItem(int index) {
    var data = dataList[index];

    bool isSelect = false;

    if (null != data['isSelect'] && data['isSelect']) {
      isSelect = true;
    }

    Widget indexWidget = Container(
      width: 25.0,
      //padding: EdgeInsets.only(left: 3.0),
      alignment: Alignment.center,
      child: Icon(
        isSelect ? Icons.check_box : Icons.check_box_outline_blank,
        color: SetColors.mainColor,
        size: 20.0,
      ),
    );

    List<Widget> widgetList = new List();
    widgetList.add(Container(
      alignment: Alignment.center,
      width: width * 0.5 * 0.3,
      child: Text(
        data['arcCode'],
        style: TextStyle(fontSize: SetConstants.normalTextSize),
      ),
      decoration: new BoxDecoration(
        //color: RLZZColors.mainColor,
        border: new Border(
          right: new BorderSide(color: SetColors.darkGrey, width: 0.5),
          left: new BorderSide(color: SetColors.darkGrey, width: 0.5),
        ),
      ),
    ));
    widgetList.add(Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          data['arcName'],
          style: TextStyle(fontSize: SetConstants.normalTextSize),
        ),
      ),
    ));

    return GestureDetector(
      onTap: () {
        setState(() {
          dataList.forEach((v) {
            v['isSelect'] = false;
          });
          data['isSelect'] = true;
        });
      },
      child: Container(
          height: 25.0,
          //padding: new EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              indexWidget,
              Expanded(
                child: Container(
                  child: Row(
                    children: widgetList,
                  ),
                ),
              ),
            ],
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
              bottom: new BorderSide(color: SetColors.darkGrey, width: 0.5),
            ),
          )),
    );
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

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    width = CommonUtil.getScreenWidth(context);

    ///操作按钮
    List<Widget> btnList = new List();
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.darkGrey,
      text: StringZh.app_cancel,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));

    if (dataList.length != 0) {
      btnList.add(ButtonWidget(
        height: 30.0,
        width: 65.0,
        backgroundColor: SetColors.mainColor,
        text: StringZh.app_ok,
        fontColor: Colors.white,
        clickFun: () {
          _clickFunOK();
        },
      ));
    }

    Widget mainWidget = new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(2.0),
          color: SetColors.mainColor,
          height: 25.0,
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                width: 25.0,
              ),
              new Container(
                alignment: Alignment.center,
                width: width * 0.5 * 0.3,
                child: Text(
                  StringZh.code,
                  style: TextStyle(
                      fontSize: SetConstants.normalTextSize,
                      color: Colors.white),
                ),
                decoration: new BoxDecoration(
                  color: SetColors.mainColor,
                  border: new Border(
                    right:
                        new BorderSide(color: SetColors.darkGrey, width: 1.0),
                    left:
                        new BorderSide(color: SetColors.darkGrey, width: 1.0),
                  ),
                ),
              ),
              new Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    StringZh.name,
                    style: TextStyle(
                        fontSize: SetConstants.normalTextSize,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: //WidgetUtil.buildEmptyToList(context,
                //onRefresh: _getDataRequest)
                PullLoadWidget(
              control: pullLoadWidgetControl,
              itemBuilder: (BuildContext context, int index) =>
                  _renderItem(index),
              onRefresh: handleRefresh,
              onLoadMore: onLoadMore,
              refreshKey: refreshIndicatorKey,
              loadingWidget: loadingWidget,
            ),
          ),
        ),
      ],
    );

    return new DialogPage(
      title: widget.title,
      mainWidget: mainWidget,
      btnList: btnList,
    );
  }
}
