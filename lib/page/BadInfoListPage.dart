import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/TestOrderBadInfo.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/page/RefPage.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/TextWidget.dart';

///不良信息列表
class BadInfoListPage extends StatefulWidget {
  ///检验单ID
  final String testOrderId;

  ///不良数量
  final double unQualifiedQty;

  ///不良信息列表
  final List valueList;

  ///确认回调
  final Function okFun;

  BadInfoListPage({
    Key key,
    this.testOrderId,
    @required this.okFun,
    @required this.valueList,
    @required this.unQualifiedQty,
  });

  @override
  BadInfoListPageState createState() => new BadInfoListPageState();
}

class BadInfoListPageState extends State<BadInfoListPage> {
  ///数据列表
  List<TestOrderBadInfo> dataList = <TestOrderBadInfo>[];

  ///返回
  List returnList = List();

  @override
  void initState() {
    super.initState();
    initData();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  initData() {
    if (null != widget.valueList && widget.valueList.length > 0) {
      dataList = widget.valueList;
    } else {
      if (CommonUtil.isNotEmpty(widget.testOrderId)) {
        QmsService.getTestOrderBadInfoList(context, widget.testOrderId, (res) {
          setState(() {
            for (int i = 0; i < res.length; i++) {
              dataList.add(TestOrderBadInfo.fromJson(res[i]));
            }
          });
        });
      }
    }
  }

  clickFunOK() {
    for (int i = 0; i < dataList.length; i++) {
      TestOrderBadInfo info = dataList[i];

      String rowNum = info.rowNum.toString();

      if (CommonUtil.isEmpty(info.badReasonCode)) {
        Fluttertoast.showToast(
            msg: CommonUtil.getText(
                StringZh.tip_isEmpty_badReasonCode, [rowNum]));
        return;
      }
      if (info.badQty == 0) {
        Fluttertoast.showToast(
            msg: CommonUtil.getText(StringZh.tip_badQty_not_zero, [rowNum]));
        return;
      }

      if (info.badQty > widget.unQualifiedQty) {
        Fluttertoast.showToast(
            msg: CommonUtil.getText(
                StringZh.tip_badQty_is_greater_than_unQualifiedQty, [rowNum]));
        return;
      }
    }

    widget.okFun(dataList);
    Navigator.pop(context);
  }

  ///组建数据
  List<Widget> getItems() {
    //List<TextEditingController> textEditingControllers = new List();
    List<Widget> list = List();

    for (int i = 0; i < dataList.length; i++) {
      TestOrderBadInfo info = dataList[i];
      info.rowNum = i + 1;
      var item = Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 30.0,
          //width: 70.0,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 60.0,
                child: Text(
                  (i + 1).toString(),
                  style: TextStyle(fontSize: SetConstants.normalTextSize),
                ),
              ),
              Expanded(
                child: TextWidget(
                  height: 30.0,
                  text: info.badReasonName ?? '',
                  onTapFun: () {
                    getReasonInfoModel(info);
                  },
                  iconWidget: GestureDetector(
                    onTap: () {
                      getReasonInfoModel(info);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.search,
                        size: 22.0,
                        color: SetColors.darkDarkGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 130.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                child: InputWidget(
                  isNumber: true,
                  initText: info.badQty == null ? '' : info.badQty.toString(),
                  onChanged: (v) {
                    if (v == '') {
                      info.badQty = 0;
                    } else {
                      info.badQty = double.parse(v);
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    dataList.removeAt(i);
                  });
                },
                child: Container(
                  width: 20.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.cancel,
                    size: 24.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ));
      list.add(item);
    }
    return list;
  }

  ///获取不良原因
  void getReasonInfoModel(TestOrderBadInfo info) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RefPage(
            title: StringZh.text_badReason,
            url: Config.badReasonRefUrl,
            arcCode: info.badReasonCode,
            okFun: (obj) {
              setState(() {
                info.badReasonCode = obj['arcCode'];
                info.badReasonName = obj['arcName'];
              });
            },
          );
        });
  }

  ///新增一行
  void addNewRow() {
    TestOrderBadInfo info = TestOrderBadInfo.empty();
    info.badQty = 0;
    info.rowNum = dataList.length + 1;
    setState(() {
      dataList.add(info);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = CommonUtil.getScreenHeight(context);

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

    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.mainColor,
      text: StringZh.app_ok,
      fontColor: Colors.white,
      clickFun: clickFunOK,
    ));

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              alignment: Alignment.center,
              width: width * 0.5,
              height: height * 0.6,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35.0,
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 75.0),
                            child: Text(
                              '', //StringZh.text_badInfo,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SetConstants.normalTextSize),
                            ),
                          ),
                        ),
                        ButtonWidget(
                          //height: 30.0,
                          width: 75.0,
                          backgroundColor: SetColors.mainColor,
                          text: StringZh.addNewRow,
                          fontColor: Colors.white,
                          clickFun: addNewRow,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: SetColors.lightGray,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(6.0)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    color: SetColors.mainColor,
                    height: 25.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: 60.0,
                          child: Text(
                            StringZh.serialNumber,
                            style: TextStyle(
                                fontSize: SetConstants.normalTextSize,
                                color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: SetColors.mainColor,
                            border: Border(
                              right: BorderSide(
                                  color: SetColors.darkGrey, width: 0.5),
                              left: BorderSide(
                                  color: SetColors.darkGrey, width: 0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              StringZh.text_badReason,
                              style: TextStyle(
                                  fontSize: SetConstants.normalTextSize,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 130.0,
                          margin: EdgeInsets.only(
                            right: 30.0,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            StringZh.badQty,
                            style: TextStyle(
                                fontSize: SetConstants.normalTextSize,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: dataList.length == 0
                        ? Container()
                        : Container(
                            child: ListView(
                              children: getItems(),
                            ),
                          ),
                  ),
                  WidgetUtil.getDivider(
                      height: 1.0, color: SetColors.darkGrey),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: btnList,
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
